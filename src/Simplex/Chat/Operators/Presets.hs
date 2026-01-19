{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}

module Simplex.Chat.Operators.Presets where

import Data.List.NonEmpty (NonEmpty)
import qualified Data.List.NonEmpty as L
import Simplex.Chat.Operators
import Simplex.Messaging.Agent.Env.SQLite (ServerRoles (..), allRoles)
import Simplex.Messaging.Agent.Store.Entity
import Simplex.Messaging.Protocol (ProtocolType (..), SMPServer)

-- =====================================================================
-- Operators
-- =====================================================================

-- Use a single operator pointing to your private domain.
operatorSimpleXChat :: NewServerOperator
operatorSimpleXChat =
  ServerOperator
    { operatorId = DBNewEntity
    , operatorTag = Just OTSimplex
    , tradeName = "Smp Privateline X-Chat"
    , legalName = Just "PrivateLine"
    , serverDomains = ["smp01.privateline.io", "smpx01.privateline.dev", "xftp01.privateline.dev", "smpx02.privateline.dev", "xftp02.privateline.dev" ]
    , conditionsAcceptance = CARequired Nothing
    , enabled = True
    , smpRoles = allRoles
    , xftpRoles = allRoles
    }

-- Keep Flux operator disabled; set domain to your private zone for safety.
operatorFlux :: NewServerOperator
operatorFlux =
  ServerOperator
    { operatorId = DBNewEntity
    , operatorTag = Just OTFlux
    , tradeName = "Privateline X-Chat"
    , legalName = Just "Privateline"
    , serverDomains = ["smp01.privateline.io", "smpx01.privateline.dev", "xftp01.privateline.dev", "smpx02.privateline.dev", "xftp02.privateline.dev" ]
    , conditionsAcceptance = CARequired Nothing
    , enabled = True
    , smpRoles = ServerRoles { storage = False, proxy = True }
    , xftpRoles = ServerRoles { storage = False, proxy = True }
    }

-- =====================================================================
-- SMP servers (ONLY your private one)
-- =====================================================================

-- For restoring short links: only include the enabled list with your SMP server.
-- If in the future you ADD servers, consider splitting short-link preset sources
-- as the original comment suggested for backward/forward compatibility.
allPresetServers :: NonEmpty SMPServer
allPresetServers = enabledSimplexChatSMPServers

-- Client presets: only map the enabled list to avoid duplicate inserts in DB.
simplexChatSMPServers :: [NewUserServer 'PSMP]
simplexChatSMPServers =
  map (presetServer' True) (L.toList enabledSimplexChatSMPServers)

-- Enabled SMP list (NonEmpty) — your server only.
enabledSimplexChatSMPServers :: NonEmpty SMPServer
enabledSimplexChatSMPServers =
  [ 
    "smp://EVXgC1uEZppwb1kP-7tcusaCjHt4xiius-v1MgXfpAk=@smp01.privateline.io"
  ]

-- Keep a minimal disabled list (not referenced anywhere else).
-- It uses the same SMP URL just to satisfy NonEmpty if other modules import the symbol.
-- We do NOT include it in allPresetServers nor simplexChatSMPServers to avoid duplicates.
disabledSimplexChatSMPServers :: NonEmpty SMPServer
disabledSimplexChatSMPServers =
  [ "smp://PW6GmzrkQP3OdKz1x3lTO67z-c0R_IKaMWQ31gxaUlo=@smpx03.privateline.dev"
  ]

-- =====================================================================
-- XFTP servers (ONLY your private one)
-- =====================================================================

-- Some clients expect XFTP presets under Flux naming; keep the binding but point to your server.
fluxXFTPServers :: [NewUserServer 'PXFTP]
fluxXFTPServers =
  presetServer True <$>
    [ "xftp://oJH7jdmfSr4C9fC8ONYIFNabnP_VatrHvjxq8nNXtMc=@smp01.privateline.io"
    ]

-- Keep these symbols for compatibility but make them inert:
fluxSMPServers :: [NewUserServer 'PSMP]
fluxSMPServers = map (presetServer' True) (L.toList fluxSMPServers_)

fluxSMPServers_ :: NonEmpty SMPServer
fluxSMPServers_ =
  [ "smp://PW6GmzrkQP3OdKz1x3lTO67z-c0R_IKaMWQ31gxaUlo=@smpx02.privateline.dev"
  ]
