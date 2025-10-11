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
      legalName = Just "SimpleX Chat Ltd",
      serverDomains = ["simplex.im"],
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
      serverDomains = ["privateline.dev"],
      conditionsAcceptance = CARequired Nothing,
      enabled = True,
      smpRoles = ServerRoles {storage = False, proxy = True},
      xftpRoles = ServerRoles {storage = False, proxy = True}
    }

-- Please note: if any servers are removed from the lists below, they MUST be added here.
-- Otherwise previously created short links won't work.
--
-- !!! Also, if any servers need to be added, shortLinkPresetServers will need to be be split to two,
-- so that option used for restoring links is updated earlier, for backward/forward compatibility.
allPresetServers :: NonEmpty SMPServer
allPresetServers = enabledSimplexChatSMPServers <> disabledSimplexChatSMPServers <> fluxSMPServers_
  -- added for testing, not preset in the clients
  <> ["smp://8Af90NX2TTkKEJAF1RCg69P_Odg2Z-6_J6DOKUqK3rQ=@smp7.simplex.im,dbxqutskmmbkbrs7ofi7pmopeyhgi5cxbjbh4ummgmep4r6bz4cbrcid.onion"]

simplexChatSMPServers :: [NewUserServer 'PSMP]
simplexChatSMPServers =
  map (presetServer' True) (L.toList enabledSimplexChatSMPServers)
    <> map (presetServer' False) (L.toList disabledSimplexChatSMPServers)

-- Please note: if any servers are removed from this list, they MUST be added to allPresetServers.
-- Otherwise previously created short links won't work.
--
-- !!! Also, if any servers need to be added, shortLinkPresetServers will need to be be split to two,
-- so that option used for restoring links is updated earlier, for backward/forward compatibility.
enabledSimplexChatSMPServers :: NonEmpty SMPServer
enabledSimplexChatSMPServers =
  []

-- Please note: if any servers are removed from this list, they MUST be added to allPresetServers.
-- Otherwise previously created short links won't work.
--
-- !!! Also, if any servers need to be added, shortLinkPresetServers will need to be be split to two,
-- so that option used for restoring links is updated earlier, for backward/forward compatibility.
disabledSimplexChatSMPServers :: NonEmpty SMPServer
disabledSimplexChatSMPServers =
  [ "smp://u2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU=@smp4.simplex.im,o5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion",
    "smp://hpq7_4gGJiilmz5Rf-CswuU5kZGkm_zOIooSw6yALRg=@smp5.simplex.im,jjbyvoemxysm7qxap7m5d5m35jzv5qq6gnlv7s4rsn7tdwwmuqciwpid.onion",
    "smp://PQUV2eL0t7OStZOoAsPEV2QYWt4-xilbakvGUGOItUo=@smp6.simplex.im,bylepyau3ty4czmn77q4fglvperknl4bi2eb2fdy2bh4jxtf32kf73yd.onion",
    "smp://0YuTwO05YJWS8rkjn9eLJDjQhFKvIYd8d4xG8X1blIU=@smp8.simplex.im,beccx4yfxxbvyhqypaavemqurytl6hozr47wfc7uuecacjqdvwpw2xid.onion",
    "smp://SkIkI6EPd2D63F4xFKfHk7I1UGZVNn6k1QWZ5rcyr6w=@smp9.simplex.im,jssqzccmrcws6bhmn77vgmhfjmhwlyr3u7puw4erkyoosywgl67slqqd.onion",
    "smp://6iIcWT_dF2zN_w5xzZEY7HI2Prbh3ldP07YTyDexPjE=@smp10.simplex.im,rb2pbttocvnbrngnwziclp2f4ckjq65kebafws6g4hy22cdaiv5dwjqd.onion",
    "smp://1OwYGt-yqOfe2IyVHhxz3ohqo3aCCMjtB-8wn4X_aoY=@smp11.simplex.im,6ioorbm6i3yxmuoezrhjk6f6qgkc4syabh7m3so74xunb5nzr4pwgfqd.onion",
    "smp://UkMFNAXLXeAAe0beCa4w6X_zp18PwxSaSjY17BKUGXQ=@smp12.simplex.im,ie42b5weq7zdkghocs3mgxdjeuycheeqqmksntj57rmejagmg4eor5yd.onion",
    "smp://enEkec4hlR3UtKx2NMpOUK_K4ZuDxjWBO1d9Y4YXVaA=@smp14.simplex.im,aspkyu2sopsnizbyfabtsicikr2s4r3ti35jogbcekhm3fsoeyjvgrid.onion",
    "smp://h--vW7ZSkXPeOUpfxlFGgauQmXNFOzGoizak7Ult7cw=@smp15.simplex.im,oauu4bgijybyhczbnxtlggo6hiubahmeutaqineuyy23aojpih3dajad.onion",
    "smp://hejn2gVIqNU6xjtGM3OwQeuk8ZEbDXVJXAlnSBJBWUA=@smp16.simplex.im,p3ktngodzi6qrf7w64mmde3syuzrv57y55hxabqcq3l5p6oi7yzze6qd.onion",
    "smp://ZKe4uxF4Z_aLJJOEsC-Y6hSkXgQS5-oc442JQGkyP8M=@smp17.simplex.im,ogtwfxyi3h2h5weftjjpjmxclhb5ugufa5rcyrmg7j4xlch7qsr5nuqd.onion",
    "smp://PtsqghzQKU83kYTlQ1VKg996dW4Cw4x_bvpKmiv8uns=@smp18.simplex.im,lyqpnwbs2zqfr45jqkncwpywpbtq7jrhxnib5qddtr6npjyezuwd3nqd.onion",
    "smp://N_McQS3F9TGoh4ER0QstUf55kGnNSd-wXfNPZ7HukcM=@smp19.simplex.im,i53bbtoqhlc365k6kxzwdp5w3cdt433s7bwh3y32rcbml2vztiyyz5id.onion"
  ]

fluxSMPServers :: [NewUserServer 'PSMP]
fluxSMPServers = map (presetServer' True) (L.toList fluxSMPServers_)

-- Please note: if any servers are removed from this list, they MUST be added to allPresetServers.
-- Otherwise previously created short links won't work.
--
-- !!! Also, if any servers need to be added, shortLinkPresetServers will need to be be split to two,
-- so that option used for restoring links is updated earlier, for backward/forward compatibility.
fluxSMPServers_ :: NonEmpty SMPServer
fluxSMPServers_ =
  ["smp://V9fPXJhPw2Jv_CaJeUwUj_gsjhaXOQIa-p27TtZ3ToQ=@smpx01.privateline.dev"]

fluxXFTPServers :: [NewUserServer 'PXFTP]
fluxXFTPServers =
  map
    (presetServer True)
    ["xftp://yTjqu2fauO7hJJQSQFAByuIkpGqw9kGTp8jJSggICUg=@xftp01.privateline.dev"]
