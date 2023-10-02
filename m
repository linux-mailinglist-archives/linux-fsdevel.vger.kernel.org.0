Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B07B5133
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjJBL3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjJBL3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:29:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCE93;
        Mon,  2 Oct 2023 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696246144; x=1727782144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8pxtuVgasoi4ShtwLlsck4blhLIMbF51rak1W9aOrwQ=;
  b=nPPCuSmbiCu4cNhmRSAVPs2HZ+yPyvBIgtRXHlVGsuoFgLou3PgB3UXD
   FXKQF+91C+C6KtoXK8SaP1GiCLQSIsZGAQZIPpBqbWE8e1TL2hKXNtlAp
   c1O+eQJ6TZPH7Akbekd05pnnDQR2GVUyIBuIYCVmdUeAXeY13N0mOpOFx
   OSOnF4eZxkpnSSe8Ilbp7AF4aNAKtEJX3UYfAmDd1Ff075mkA/GORZQ7y
   4k3t0RF4mhALejVudwM0X7iCVHZ+FLRF0BhqAeIBkB7YQRHb2mnuB5AXw
   a8hu1a2wHeYYMuMdZSnFdu4zKcVgz/q+YCWAaCeYTXHJPjR52iBHygB+3
   A==;
X-CSE-ConnectionGUID: br9oliHlSOWmVi0WmQ67mw==
X-CSE-MsgGUID: LYJFwKtWQS+6LgRZend27w==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="243639104"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 19:29:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtL+605M2VETpIK+Erq1xJhviW7dWAXxhhB/Cnjq+uVVGA6sEvu6LVf+4jCU+zwcGnTXjMEz0I6YtLwmvm9mz/sBGLWJV81TEDInIkaT1rtGbHMG66EETfgCQYggSs303gy6/nUkfOXKVakBGYPPvQvKm8oz3wHhluf6uL2lcut1pqH06iTzoeojKcPpnGezSUggHpqThQHmAenVLqHET1sUUe+380IbvgCgKwIQowKM7SEcxq6rKjbE+yelxUzAMq281/ikC0yBX9z4XmVWG6dF2u4tVuTAE+jg9b4m0iMzlc1gBMl9apZFtbw5GMgfDE3D6ZWNuGQFekU8mC575w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pxtuVgasoi4ShtwLlsck4blhLIMbF51rak1W9aOrwQ=;
 b=eP8pTGk6ISTIfCSwUC/6KrRV1SKAd/n1kltiSlGh0gdTMr7t0TspADTYFVXgj7d9wMkdEnND07wDrtwMSWHCLBEnmCVzpijJusaknJo78dgnjTxUj4J3Cr3tGOY3xP3nTW5DE0UGXZQGDkvsy4G/i+QdQnhB196hgq6YfHxiitJsIpIt6TFWiBFxyR4O2Em7435zucXfPN8NtnDvJ1o3EbbupcQ3eWrl8i2T3GhsKQS1+YjbgAT7wGLg5L2yIAb9UznwIlcbnXV+OIcZ6edXYpXzrL5GKnkqP2EptOZKan8mYHpTXTMUk/a8J6BhCCuRC2V3SBjNqpLzYdBUU5tKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pxtuVgasoi4ShtwLlsck4blhLIMbF51rak1W9aOrwQ=;
 b=JzI5TnBC9qQxuovwNbFI1ZJdrGu3XWhixLR0z77mD5LAMz8yddeLzDYlgaMg2EQEDSyBUxstiKn0YNDzpj+K80fL0ZUQUao9eZJdWg0x1prhWyPKUxDHyEu6GSJ4k92Of5thQTIxSaRfR+TG4lPbW8c3rLdyKDUX1m1bDHXfEvA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8575.namprd04.prod.outlook.com (2603:10b6:510:291::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18; Mon, 2 Oct
 2023 11:29:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 11:29:02 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH 05/13] scsi: core: Query the Block Limits Extension VPD
 page
Thread-Topic: [PATCH 05/13] scsi: core: Query the Block Limits Extension VPD
 page
Thread-Index: AQHZ6/b0dEwAhH+vakayX0RhATS+m7A2bzDQ
Date:   Mon, 2 Oct 2023 11:29:02 +0000
Message-ID: <DM6PR04MB6575C23E6499F15F060B49FCFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-6-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8575:EE_
x-ms-office365-filtering-correlation-id: 0ff4920e-4feb-4e8f-43c4-08dbc33ac73a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gW85Qejl8G+kKDdinf9g/EgYfamla1YNZkqs5KT1whP9OBSGjwET79KCk19T+ErMWLNJ+KLjOwoY4JU2Lc6C2DQpjcwJtJRV6FkFRyLPaYs1lRmkXEtQ7vkJYFWoPE8tI+Z9Fro1DKvea9a+q6Lflim6c5zIn4UmZ68xVwWieHYy1hI9hcSvJTREdLnWOplzAR1Di4Y8BGOca+T/xuEbRvnm/ntmyssN/0zlEOgBFNbEtJoaxba5vzNfdCMh8iily8AX67LLK42gHdQoAggqEb6RRDh0t9EKmaOL0VRofVA2nVhRu4tiL4PEFMN25zlAeURnmQq+OJ8YkX7RQwKw3ddX9up28aZMjaculXXgY6EUfS2MQ0uJjUGXxzliIL/ERWypG8XJ2GdJYG6T/CXqxnmBDXUOdkprwJUJtiOdP+QtCNmgknI6JET7d2CcRWq0Q2XHDSq2YrzSOoSARjjS5Fwsurk+QLlULp+ppMOE4+6AMz+X07RYeuf9a+JLvDvrx63McmsZvhaAJAqHMtsCTl1eZUPVSBkb3aD2ZaRvPtohHH4AGfMiAHIPLCNzFZKESn0J6HhAfsKjlPzlGtvPWqvz/EK9+EBLAhrOC5972G8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(5660300002)(4326008)(8936002)(41300700001)(316002)(8676002)(54906003)(110136005)(64756008)(4744005)(66476007)(66556008)(66446008)(66946007)(52536014)(76116006)(2906002)(478600001)(7696005)(55016003)(6506007)(9686003)(26005)(33656002)(38100700002)(71200400001)(38070700005)(82960400001)(83380400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mU72axRDdP2EWi+39SSjGr36pnovZ8ljrk3eiKDe964JHXzLpWk2dnac+XRG?=
 =?us-ascii?Q?8kNc+owHwe7DoNdwU7efQBZ5qXVYPWrPHl+pVM+HETKp8z50X4QW2I7M52SJ?=
 =?us-ascii?Q?ItNYX2NPaDhHsL9nRRnoWKuZMgAhnlH9j0caigZogwqsRkZFqsbRzD7IRSFS?=
 =?us-ascii?Q?l15DU7DjaXBcZfz+Manexls/4LBNMkA7rAdXxWqKrjdWrziCG3NXEM3tYwIb?=
 =?us-ascii?Q?sjKXq/RXGaSy1eSJFdDjl3FZaS+9P4/m7lZbRkUJIN7gVoSy1j4H0V7k0Mlk?=
 =?us-ascii?Q?wm3qlL+wrpImNC2rHis7V9u9QewpaKfNY+3ZRfQzWr886NSzzETcNPptiWcK?=
 =?us-ascii?Q?NmAfUA2CQOVOoBSIT61LIKzHw0rtb/50osoUJQHLR8GQuytFaSr5LcXQc2UR?=
 =?us-ascii?Q?l7p1J2ILWUafC0QY+vLO2QqSrL43yypGB2NB61+G/cC9gGhjzshq8k9Ne9PF?=
 =?us-ascii?Q?Bv25kHrlYKUzV4NTalhFV3p4H6keXz+4/+xODbLrhncxPRErICqphPjQB610?=
 =?us-ascii?Q?9vk+NoKS1dSVZtbc/w0n2SkNJ+DM3WYKUfHJCMnc6Os6Es9eQBDvla6aEsSX?=
 =?us-ascii?Q?IIYZpMSG28QgJgEX0K/1r3M0KpHunZjuCtMxC+GjZKWr9cYUwEiBH7O+yEgn?=
 =?us-ascii?Q?L8Pmz3Y1XNzDI+OO3VK/wyjCKzn5a+WXP9IMADwSwQTriphga4Z1Jcn3K4y8?=
 =?us-ascii?Q?xNhAzzLRfO/b+cn16ZfC/+t/Z1FCyCpAp/E2n2x1CggO4npo4+7ezsUg15eB?=
 =?us-ascii?Q?uG+f2Aw1ernzJ1btWY0rfDpCx44mwPJwCpB+MMWLEf48MvgDgWhZ7LuuTti+?=
 =?us-ascii?Q?lLLCa7jzzORT2R0TGnwWBPMsrwT73mVp8xSvENTzf8loizc9NOspdB2n7hVw?=
 =?us-ascii?Q?HQiH77SP3mvjRmssYZBqssGos2Y/JEtlVqqCS1yllrLJe697TJI9ZbjCFOlV?=
 =?us-ascii?Q?FuArSEeY0thHlHhzWf9y7kmmTny7fyv/5wqD1VKxL/H3YDQNE2+53+nT9XUZ?=
 =?us-ascii?Q?VBNm93FT+8qtorbbPq1btvUK66hveUspXTH1LLXqIS6SOYAj4Fr/295W3ORh?=
 =?us-ascii?Q?/dsskfRz+Cc+lZ28l1Fnnnh83bbCKIqPd7/LeCdXS9FSQcmESjmDLuuxaX/J?=
 =?us-ascii?Q?tG2pMoQf+t5CN6858vv4Kug2IVuhl45RrKFyDUKkT7Sxh9fn6Oas9paB8WcY?=
 =?us-ascii?Q?i6U3dxBu9OLYGgTD3kkS+g1+B/j9g7culYAHYPG8PJ1s+2tgpMpPAV0/N/Vq?=
 =?us-ascii?Q?3TbfzRFioNpMpFiGGyGgaiCYdKOzzFa1QNH5bl5dK6p7NAS5b6nAW5hYvUrJ?=
 =?us-ascii?Q?pCuvKb5ACKqfgky3FIua0RvDRNlH+leOXZhJ3Tsy+WBkfvLn+7zOXsgb9QE6?=
 =?us-ascii?Q?hMRXHl9zpA+4vQCdOAQ1PkjhqV+QqC0DKhlNNwvK3n4Ixes50nbzIG1/+FGc?=
 =?us-ascii?Q?wC/mZkkbj+toeWo7TGJ6fFbH2dniubZ2leQntNA4Xd54X+Rq7LDi6p4HqemS?=
 =?us-ascii?Q?w46IzcCS6vvOvmLU/MwL4pOl2Zgllq6jdP121NyixTu0KD4FyrgVeKtB+JYe?=
 =?us-ascii?Q?2p9G2mkxYO254eYXRUvHnLRruLrqEIoTwdqRbsYH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Y3EQMxU46vEeozguggc7rD9gpLKW63/ly887fb0Tyl5wI9hPwfgoGX/384p/ribEPYaDKCx8AF0TUufsPwFQf40N+RXXLRsTK8McDy7nJhDmEYRFdSCzncij78ZDeCt9QYP51m6gW6kMf4UvcsedakafDQF428+URKv8Gpe3CVQ3ZndXSS1fo8ko/tg8D54nNT4+6oC7rOV7IkxbI+d9tx1kzdNI9AJMyouHdF3B1oh7YFRTgMCzA2LFnav9I/78BCcV0XTC8u79/pEvs7hutOgU+SjnEqZlbLUEjppq+x1o47Z9s46Ns2SmN+F7O/DEq0davmTOlY1vk4nGOTYSQS46ELMVELa/b5XK6a2LDpUhrtfIQkUI2Bv8m2Eeik+8jwAJNVhnykKAxpjfvjvn4DhaEX/EbyZme2B+87B0wjwWvCSpqtDdHUVkkpGYvSq6JV/6ZW1kWIczISm73Qadq2b7KtTsp0JUtxgwIL1atZhfdn3g9ABSpWrdB7v33ft/zWbXoEV/OIn6+ULK0bUiseYsKbi5j9X4/HRPCD8/txNLpg3S9QueKFlCbr843g/CP6k5O+mGa0qda6AC+tP+7lfth4jgccjGFxwKHpcG+aIStYqO+TmStBPF/1dsgDELTEzca8GykQObhFx/NMvPvqmpvzOUeBR0Kbz5FLJAPsBCxEUEu+tcv7abgMjFPdj5EcqFraNGSOjmDcUigsk1XepitV6ejdHYU/02Lf7AeqjF8wCzjttz3USpZt61lDsY/3crQnQUnsQWmUMvHSWGX6VVgkL71QHp62FgXnsGHCro6dFHBBHlIWE/Pc7tI7tBDX/jhsuhuWWUq51aVukUapD6e5MkRLMmVijXm68/koAGU7DigtU0LGsKRIfe0f2UZAsmSGEnZWRxMK2TCGrEgUazSZy2vge8Fh+r+GxbeA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff4920e-4feb-4e8f-43c4-08dbc33ac73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:29:02.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsqbmd3QWpEdTIDEbH+u1CYy9NEtY588KJ2pozvc0uslIVMO8Wx+B/s+OU8pyRuDJgstfDCFs8aOXffsme/dAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8575
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Parse the Reduced Stream Control Supported (RSCS) bit from the block limi=
ts
> extension VPD page. The RSCS bit is defined in T10 document
> "SBC-5 Constrained Streams with Data Lifetimes"
> (https://www.t10.org/cgi-bin/ac.pl?t=3Dd&f=3D23-024r3.pdf).
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
