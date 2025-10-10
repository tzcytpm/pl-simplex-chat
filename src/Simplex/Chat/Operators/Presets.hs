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

operatorSimpleXChat :: NewServerOperator
operatorSimpleXChat =
  ServerOperator
    { operatorId = DBNewEntity,
      operatorTag = Just OTSimplex,
      tradeName = "SimpleX Chat",
      legalName = Just "Private Line Ltd",
      serverDomains = ["privateline.dev"],
      conditionsAcceptance = CARequired Nothing,
      enabled = True,
      smpRoles = allRoles,
      xftpRoles = allRoles
    }

operatorFlux :: NewServerOperator
operatorFlux =
  ServerOperator
    { operatorId = DBNewEntity,
      operatorTag = Just OTFlux,
      tradeName = "Flux",
      legalName = Just "InFlux Technologies Limited",
      serverDomains = ["simplexonflux.com"],
      conditionsAcceptance = CARequired Nothing,
      enabled = True,
      smpRoles = ServerRoles {storage = False, proxy = True},
      xftpRoles = ServerRoles {storage = False, proxy = True}
    }

-- ============================================================
-- SMP servers list (ONLY your own server)
-- ============================================================

enabledSimplexChatSMPServers :: NonEmpty SMPServer
enabledSimplexChatSMPServers =
  [ "smp://V9fPXJhPw2Jv_CaJeUwUj_gsjhaXOQIa-p27TtZ3ToQ=@smpx01.privateline.dev" ]

-- Không dùng các server khác
disabledSimplexChatSMPServers :: NonEmpty SMPServer
disabledSimplexChatSMPServers = []

fluxSMPServers_ :: NonEmpty SMPServer
fluxSMPServers_ = []

-- ============================================================
-- Preset servers used by the app
-- ============================================================

allPresetServers :: NonEmpty SMPServer
allPresetServers = enabledSimplexChatSMPServers

simplexChatSMPServers :: [NewUserServer 'PSMP]
simplexChatSMPServers =
  map (presetServer' True) (L.toList enabledSimplexChatSMPServers)

fluxSMPServers_ :: NonEmpty SMPServer
fluxSMPServers_ = []

fluxSMPServers :: [NewUserServer 'PSMP]
fluxSMPServers = map (presetServer' True) (L.toList fluxSMPServers_)

fluxXFTPServers :: [NewUserServer 'PXFTP]
fluxXFTPServers =
  map
    (presetServer True)
    [ "xftp://yTjqu2fauO7hJJQSQFAByuIkpGqw9kGTp8jJSggICUg=@xftp01.privateline.dev"]
