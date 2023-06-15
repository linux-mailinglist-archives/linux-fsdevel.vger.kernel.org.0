Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E186730E22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 06:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbjFOE3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 00:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbjFOE32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:29:28 -0400
X-Greylist: delayed 3590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 21:29:26 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6CA212B
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 21:29:26 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENLK1V030487;
        Thu, 15 Jun 2023 03:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=AOL5ot312TBpsYB2SJLfmwQiP99A4RF1n5uHkWVx2KA=;
 b=NiaJj88L5iijPY932/mIjEI+o+hTfW4KnReOz8ozgBoEa6oxNMRFbe4L63bQ5ZTsHLoM
 jbOoV+wrTWFByIDai4AOkujSPpElYmtXEiUjIVDpHdyRyN/7GdaqHcENMh8YGpqQ9mqJ
 3MgSTyUw07kqsUTmrVBgEfZAivIR6wGRoOuOsRkqGh+QCCSb5gSSXlsCapybOQtBdKDl
 r1cZNTOFfyh4Cwp4uswzqIJ7LtbFE5kzqS0pqgljYnMwug0/7f84VGmKkLAn5/XvqnKh
 yDk6xvGnCi9712V80O2B955NiMHUyaq0cYWEB7Nda+tYg2+NhZ+8PWJjTDnF0ekVKSlY QQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2106.outbound.protection.outlook.com [104.47.26.106])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3r6uunsna5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 03:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W18jtP/s/UGvmVRfcDvtDv4NtzwsbD71vDdXvLnk3TgbNOIaIbVUg+jcE7nR8tZgCcKwbC+DmU++6IJ36l9O1TyAWeQTzbDqb7dpAa3WYR8cymRdeS7R0s0vby/ULxg6dBlBB6H0uryoLdJCz/egLQtgTOf+R3mStFeQPIyFohJsmmycvLLM9oYLuk6kj9FJmoGcl549OecQaaKRqygAj6VkBwkP6ypPgLkDFsUIjUX5+XdluLFXDTOfMeHWJYHXCWdVNT7SuT1+szLladmWsL7x/o2rBXQ+nuXjme3qW2TpNI79IMwB9934ehcGLX2L9CeP9g0vh39ZuL/BgjNWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOL5ot312TBpsYB2SJLfmwQiP99A4RF1n5uHkWVx2KA=;
 b=ir0w/Czi42P2db3ahsXMpIgRs+4TTkI/N6Q2ED/tYxCGafIt1PuEaW/3/BPO93kVdU49jyKzAPjCuMFVL3jReXByl2pZ4MB15EBr7ZegGwHAhcMxQiKJxeEzEsA0xZQoaOe7GRbKUjhVkT8rt7E/Tbh1vvensEOAonT6atMrCMn42t7YPR4rS/oPCa5F9qATPeOY20IqSJXU3awg0r+uTPTTgwoGnrLSyEBUCKziMZO3zADF2AtI4xJrNtrorxg8XUJWAh66QNhRwM52ElGHESy5dqQyEb7O8M1ZlEpClhwIB1dDQKxrrTwivaPy2kh2YAAqPMDtTnu+L/4zgPGe0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4212.apcprd04.prod.outlook.com (2603:1096:820:27::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 03:29:13 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275%5]) with mapi id 15.20.6455.037; Thu, 15 Jun 2023
 03:29:13 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 2/2] exfat: do not zeroed the extended part
Thread-Topic: [PATCH v1 2/2] exfat: do not zeroed the extended part
Thread-Index: AdmfORbaqcRl7y32Sz2Kb5mg+c6LvA==
Date:   Thu, 15 Jun 2023 03:29:13 +0000
Message-ID: <PUZPR04MB63164F533A6BD865BA37829F815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4212:EE_
x-ms-office365-filtering-correlation-id: c760dad0-9624-47eb-9125-08db6d50b0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hz2C5hY+kWLEUJOkdry82CeWWVDRaJoy0No3XHrYEi7FqnroBxdaXQytwe/IEpeemV1SITK6MDiHjupxp+LvDSh8gAe+AO2wf09QebWtZaliWcW8H8ha6t5zXkgihU8uN9k06xEZYeXs7X5ORVOY9tKC9FvJ/IrCKqkFwbBMigdopvI9d5x3HK2tvKlp/qEKCZbWPdTFEHEOg2wxCYJefDflYp9GLiVaqkDGA40BrM8H62KqqK4r4wJeKM9TwABWIdfgi4JZ2fMn6wGpX+qqbN5uqSsifvHN5m/kq+Ccr66nWw+wQsa8Vz1dF6TGcc/DGOYuSj0SS+9BLDGnxXFem5GPG/nVKTKHcppNXaUjs0+heOS4UhxdwIqVOZ/yAknVEIDn/ThOVgb7TKLtOJHBeBmwFCUl0kQnhqody3gDimbUpTSbhuqR7xmYtxyYkJXKUapl2ec6QT0IR8cO8YGGusoYPjYWRCeE+oYMEPTIQwO50y1G8waT1xHfbAypNeiP9wNqBjAxXSAyLuMD54lU91pwpziCLQ+syrKGELexoCbBRCkZeAikraKSt5Ou+8bsoARirzzxT2iFbrTKDGwqvimMVZmTtjeQYrXpTcsrOWTeWE1kX5aJZOBiSBlHVV+U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(76116006)(4326008)(2906002)(86362001)(38070700005)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(110136005)(5660300002)(52536014)(8936002)(8676002)(54906003)(38100700002)(478600001)(122000001)(82960400001)(7696005)(71200400001)(83380400001)(107886003)(55016003)(9686003)(26005)(6506007)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDVCbTFGaWMyY21zbW04NWxJLzV2a2Q1cEI2eCtmOGFDNUljZm9JTGNrQUk2?=
 =?utf-8?B?YkdSZlNZUkNhT2VXRzN0Ui96eWJqVzV5QkpIdUdLRWVRZGMzNEFlSXJtMEJy?=
 =?utf-8?B?M3I5NXpIb0JtaktScmwyVE9LVTFlT3JuM2NuNTQ1bG9vWURScVlVdUNSdlVo?=
 =?utf-8?B?SEJ2ZlM1OStzbFp1bU44OFFhVEQ0S21nRDA2QlN6QXVDU1lxSHJoWEVxK0NF?=
 =?utf-8?B?cDJycUMzR3l0b29mTlVuWHUvdW91U2g3ZkI1VWJKUTRscHlQMWR3YUZEUCtp?=
 =?utf-8?B?NmRZUVY0ZWdIakJoT1ZFdlFmMVVTTUFqM1dMVHpOY3pjUmxUWHQybVViNGxv?=
 =?utf-8?B?ZUlHR2ZzUkFGcDV0RXVoNWFBNFpJeDRaNWgvVmRQS1U4ZWhvS0dYZzhQRzIy?=
 =?utf-8?B?bnVmRkdjbmZxWCtBUHc3WUd6Y29zUXQwZUxTU24zQVNKT1kxUm5EM1M0VEhM?=
 =?utf-8?B?MUpmRlRGUGhpK2swN0V0Z0FDU2d4RXBjenJYUTFuRlRaOUQ3MlZRQ1crK2p5?=
 =?utf-8?B?bW5SbnN2MmxvTXk4NW9ydXllRW16NHkva0dtY1lLRGZhc1JnNWZzRGIrTG1v?=
 =?utf-8?B?NEFocUUyeisvQk45VWNKZDd2eEo1Sk5EVmhteGdET1RBNFF2Z1VGMXlqSnVL?=
 =?utf-8?B?SkNvbkUvMDlpTXdsMkNzd093bTFDOE5oMGN4TFFVdDJ3R3NjOTJtOCsrSnVL?=
 =?utf-8?B?Q1FvY0JONzVOa1pTM0pnSElKVnhIeGhiUDFsZWtOL1VoMGdhUWxnbWdqaTFW?=
 =?utf-8?B?MlBvNmwxNFZYVmJmc1piSzczd25ReGJWTEFHQU9MeUNBS2tVTEFoTFhBVUxy?=
 =?utf-8?B?aEFvNVhqVDBtWTNjYS85OE9vNXNpOCtxeWpLL3FNeGpxeC9adzlvUG5qSCtr?=
 =?utf-8?B?UFZqWlNxaFBTRi9rNmIzTmtuY285WUV1bmFQdnZWQ05YcGJNL3BaL3ZzS2lU?=
 =?utf-8?B?RW9LRjVNOWpON2J0MmcwRnhqNFBMc2ZyMWNZVFZoejRDV2trb3N6Z1hkRitz?=
 =?utf-8?B?R0RUdVdVSFlGYWtxa0RsRkpyamptbTByQVQxdWQwSVNkckxXamRPY204NnJP?=
 =?utf-8?B?Z0RKUFE2ZjkvUEw3TTMwcDZzclhSeGp0aTRIUmpaRGlNcGZmSngwVitMdjlO?=
 =?utf-8?B?bC80ZFdPeFhrYjRUR3lwTjdXRVJLcURZbE9Ccm42dXFiZ3k5U3hyTTA4bUlt?=
 =?utf-8?B?QlRCUjVCVFVXNHRtZVRKT2NpOWtLZUx0RlVpOEdIUEhFR29TclJ5S2x3T2Mz?=
 =?utf-8?B?SHJoRUZoMUY3djd1QnM3N1lycXkzWGVDMVZ3enovdU1yVXlrRk5JSTQ0L1pP?=
 =?utf-8?B?T3BjYWd6d09RQ3BsVytUaTdkekJDQUdqUWxFaGQvOXBFaXVBakdTUEFSZkxW?=
 =?utf-8?B?ZjE1MlprK00yUDFNNURNOEovLzBSVTRlMThrbnBsU2NvUjJYNThpOU5RUkRG?=
 =?utf-8?B?cWcvVk1HLzl4N1gyTHZlVmdubCtySTl6Vzh4aUoyeEhzdGxvWDJyd2lXaWVQ?=
 =?utf-8?B?dnRvYVVOY0FUSU5jRUY5dHlmNDFORHF6WkJrOTFjNFI0SWR2dkMyZXRYaXpR?=
 =?utf-8?B?QU16SnQxS2dGUEVZTjhwVXJWQUZ0V1YzME0rTnRCU3J3bGxCM3J0MUtuNnd6?=
 =?utf-8?B?a3UzWm9yMEFIYW11RDJGUzl4U2VzVVRoblk3UzBabG1abWh6SDBtZEdLSGNC?=
 =?utf-8?B?Vy92QXg4dWRlZ3gwWGpJWUVvamZySkJoNTQ4S0gzcDJFa1VPQWJRdERlS3ZP?=
 =?utf-8?B?azBFUTExdjhiWm9SS0ovbnVIeUQzS0dVaEV2S0ZHNlM5TzVQNW1NVS8xRnl6?=
 =?utf-8?B?dEpSdjZzaFV1bmxIRWFEQmp4TVVSNmorWTJTVXBFWDBOUXdNNVkvaEw3S0t3?=
 =?utf-8?B?UEg5OWovZ0ZlVXlDQ1FWUDBsa2hoR0JVSWorU25wTEl2U0t5UWpXQnNpc0lN?=
 =?utf-8?B?QitTcWljWEIyUUkvbXJkanhLbVRaRjV2cURBUXZvZWE4UG5mb2lxWjNYQjhU?=
 =?utf-8?B?SXQwRHptNE9Pb0lJbE5zaFp5dnpFWWRYek8vWXVHVWdhcTQ4Z1laNVk3eHh6?=
 =?utf-8?B?cXp2YmZVSFpwNWlYRDg5ZHU4VjRPaE16TTN1aWMxeEt1MWhJUzY4MHp6UWRt?=
 =?utf-8?Q?kjAfr+Wt3E581CKZ5mza+7D2c?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CF4jTwv5+PENww1h7VutkIuvrXXBX/Ipt0uLH63/9ZIMnetanbwbw/IRyAN07mhi57TDQcZM8562brtIBiMbIhBv/QekmrDcrgRQmPUeY7vmI1mScV+7iLCIIUt1Ih8Vk5zGdTsZxt5utcIGy46JP/rGi8lfjk9SAbVKiiHCvPc7IGZ6eAZvV6HdJNiv8PCRmPsImVNKo8b2rKX+Z4WvGtHxTAjeFSMia69MzvCVLs6BZ+d+02YVtvhobvVbRVsn497JWSvEj176AVNSSUzUJNhce1e3YbJelN0VYezrLobRQC6DTqdKXgJHMk2/0+vuZLM8VJhwW17MLPkOR6kaYEP0iJPB64TaDDT2BZmMhMOIIawo/KplRrRGw2sousQ0pesGTaTgH6BpMPXoipSKskQ96NbGc7yb+u/NZYTeNclS1rLCSOCKiHOxNVgeDIH/R3u6oT21RORFfOcDYVlHmVRssJV0vYDFq+Gs038bCjM+hZDAfV8xMGoLl49JCiYT3JgPzr65H68BrKJa5dZTE034ner/oznPE7MH3C5KRwtNd0Ql8gyYITtJWctkOhMBrjOYybzrpgsyzXsaDhPCq6EWv3K2UbeUrLBtfIygnqfKs1sWNqLzVjKFevB1/bqo5PY15b/qAOLwv7fYKj4VFhCRvZH8D7Cyi9wAhQGAX0MjMimr6PODNbpMJkW4z502kl+PA5LDkIr1/z+s8F2tnVrLOIVInblfLEVjANjTJmyglwC9PnaWq0V7K2rGaD8VZT8D5alCJieDF9d1syCoM/i2q9PBTlxpEo7EcI/QBG8M+bvkUZ2V3P4yZSsJzDmhhMCNChTg1hLpvIZu3Vi7ow==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c760dad0-9624-47eb-9125-08db6d50b0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 03:29:13.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLR+tEfUBwh8BwWV25YXFmEsYv3ZgEmn3ANvGjgRz5dowVVE2yrkG4tAgikiGQcG0jFj6Lxr2vMcFzm77NV2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4212
X-Proofpoint-ORIG-GUID: kqguvwZoEGSWlj_8xLfsZKbPQX2LoqHS
X-Proofpoint-GUID: kqguvwZoEGSWlj_8xLfsZKbPQX2LoqHS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: kqguvwZoEGSWlj_8xLfsZKbPQX2LoqHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2UgdGhlIHJlYWQgb3BlcmF0aW9uIGJleW9uZCB0aGUgVmFsaWREYXRhTGVuZ3RoIHJldHVy
bnMgemVybywNCmlmIHdlIGp1c3QgZXh0ZW5kIHRoZSBzaXplIG9mIHRoZSBmaWxlLCB3ZSBkb24n
dCBuZWVkIHRvIHplcm8gdGhlDQpleHRlbmRlZCBwYXJ0LCBidXQgb25seSBjaGFuZ2UgdGhlIERh
dGFMZW5ndGggd2l0aG91dCBjaGFuZ2luZw0KdGhlIFZhbGlkRGF0YUxlbmd0aC4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyB8IDgxICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hh
bmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Zz
L2V4ZmF0L2ZpbGUuYyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KaW5kZXggNjgwNTk3ZjMyMzdkLi4zZGFm
MzFhNGIwYWIgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9maWxlLmMNCisrKyBiL2ZzL2V4ZmF0L2Zp
bGUuYw0KQEAgLTEzLDcgKzEzLDcgQEANCiAjaW5jbHVkZSAiZXhmYXRfcmF3LmgiDQogI2luY2x1
ZGUgImV4ZmF0X2ZzLmgiDQogDQotc3RhdGljIGludCBleGZhdF9jb250X2V4cGFuZChzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBsb2ZmX3Qgc2l6ZSwgYm9vbCBzeW5jKQ0KK3N0YXRpYyBpbnQgZXhmYXRf
ZXhwYW5kX2FuZF96ZXJvKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplLCBib29sIHN5
bmMpDQogew0KIAlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGlub2RlLT5pX21hcHBp
bmc7DQogCWxvZmZfdCBzdGFydCA9IGlfc2l6ZV9yZWFkKGlub2RlKSwgY291bnQgPSBzaXplIC0g
aV9zaXplX3JlYWQoaW5vZGUpOw0KQEAgLTQzLDYgKzQzLDgxIEBAIHN0YXRpYyBpbnQgZXhmYXRf
Y29udF9leHBhbmQoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUsIGJvb2wgc3luYykN
CiAJcmV0dXJuIGZpbGVtYXBfZmRhdGF3YWl0X3JhbmdlKG1hcHBpbmcsIHN0YXJ0LCBzdGFydCAr
IGNvdW50IC0gMSk7DQogfQ0KIA0KK3N0YXRpYyBpbnQgZXhmYXRfZXhwYW5kKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIGxvZmZfdCBzaXplKQ0KK3sNCisJaW50IHJldDsNCisJdW5zaWduZWQgaW50IG51
bV9jbHVzdGVycywgbmV3X251bV9jbHVzdGVycywgbGFzdF9jbHU7DQorCXN0cnVjdCBleGZhdF9p
bm9kZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOw0KKwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
ID0gaW5vZGUtPmlfc2I7DQorCXN0cnVjdCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZBVF9TQihz
Yik7DQorCXN0cnVjdCBleGZhdF9jaGFpbiBjbHU7DQorDQorCXJldCA9IGlub2RlX25ld3NpemVf
b2soaW5vZGUsIHNpemUpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJbnVtX2Ns
dXN0ZXJzID0gRVhGQVRfQl9UT19DTFVfUk9VTkRfVVAoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmkp
Ow0KKwluZXdfbnVtX2NsdXN0ZXJzID0gRVhGQVRfQl9UT19DTFVfUk9VTkRfVVAoc2l6ZSwgc2Jp
KTsNCisNCisJaWYgKG5ld19udW1fY2x1c3RlcnMgPT0gbnVtX2NsdXN0ZXJzKQ0KKwkJZ290byBv
dXQ7DQorDQorCWV4ZmF0X2NoYWluX3NldCgmY2x1LCBlaS0+c3RhcnRfY2x1LCBudW1fY2x1c3Rl
cnMsIGVpLT5mbGFncyk7DQorCXJldCA9IGV4ZmF0X2ZpbmRfbGFzdF9jbHVzdGVyKHNiLCAmY2x1
LCAmbGFzdF9jbHUpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJY2x1LmRpciA9
IChsYXN0X2NsdSA9PSBFWEZBVF9FT0ZfQ0xVU1RFUikgPw0KKwkJCUVYRkFUX0VPRl9DTFVTVEVS
IDogbGFzdF9jbHUgKyAxOw0KKwljbHUuc2l6ZSA9IDA7DQorCWNsdS5mbGFncyA9IGVpLT5mbGFn
czsNCisNCisJcmV0ID0gZXhmYXRfYWxsb2NfY2x1c3Rlcihpbm9kZSwgbmV3X251bV9jbHVzdGVy
cyAtIG51bV9jbHVzdGVycywNCisJCQkmY2x1LCBJU19ESVJTWU5DKGlub2RlKSk7DQorCWlmIChy
ZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwkvKiBBcHBlbmQgbmV3IGNsdXN0ZXJzIHRvIGNoYWlu
ICovDQorCWlmIChjbHUuZmxhZ3MgIT0gZWktPmZsYWdzKSB7DQorCQlleGZhdF9jaGFpbl9jb250
X2NsdXN0ZXIoc2IsIGVpLT5zdGFydF9jbHUsIG51bV9jbHVzdGVycyk7DQorCQllaS0+ZmxhZ3Mg
PSBBTExPQ19GQVRfQ0hBSU47DQorCX0NCisJaWYgKGNsdS5mbGFncyA9PSBBTExPQ19GQVRfQ0hB
SU4pDQorCQlpZiAoZXhmYXRfZW50X3NldChzYiwgbGFzdF9jbHUsIGNsdS5kaXIpKQ0KKwkJCWdv
dG8gZnJlZV9jbHU7DQorDQorCWlmIChudW1fY2x1c3RlcnMgPT0gMCkNCisJCWVpLT5zdGFydF9j
bHUgPSBjbHUuZGlyOw0KKw0KK291dDoNCisJaW5vZGUtPmlfY3RpbWUgPSBpbm9kZS0+aV9tdGlt
ZSA9IGN1cnJlbnRfdGltZShpbm9kZSk7DQorCS8qIEV4cGFuZGVkIHJhbmdlIG5vdCB6ZXJvZWQs
IGRvIG5vdCB1cGRhdGUgdmFsaWRfc2l6ZSAqLw0KKwlpX3NpemVfd3JpdGUoaW5vZGUsIHNpemUp
Ow0KKw0KKwllaS0+aV9zaXplX2FsaWduZWQgPSByb3VuZF91cChzaXplLCBzYi0+c19ibG9ja3Np
emUpOw0KKwllaS0+aV9zaXplX29uZGlzayA9IGVpLT5pX3NpemVfYWxpZ25lZDsNCisJaW5vZGUt
PmlfYmxvY2tzID0gcm91bmRfdXAoc2l6ZSwgc2JpLT5jbHVzdGVyX3NpemUpID4+IDk7DQorDQor
CWlmIChJU19ESVJTWU5DKGlub2RlKSkNCisJCXJldHVybiB3cml0ZV9pbm9kZV9ub3coaW5vZGUs
IDEpOw0KKw0KKwltYXJrX2lub2RlX2RpcnR5KGlub2RlKTsNCisNCisJcmV0dXJuIDA7DQorDQor
ZnJlZV9jbHU6DQorCWV4ZmF0X2ZyZWVfY2x1c3Rlcihpbm9kZSwgJmNsdSk7DQorCXJldHVybiAt
RUlPOw0KK30NCisNCitzdGF0aWMgaW50IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIGxvZmZfdCBzaXplKQ0KK3sNCisJaWYgKG1hcHBpbmdfd3JpdGFibHlfbWFwcGVkKGlu
b2RlLT5pX21hcHBpbmcpKQ0KKwkJcmV0dXJuIGV4ZmF0X2V4cGFuZF9hbmRfemVybyhpbm9kZSwg
c2l6ZSwgSVNfU1lOQyhpbm9kZSkpOw0KKw0KKwlyZXR1cm4gZXhmYXRfZXhwYW5kKGlub2RlLCBz
aXplKTsNCit9DQorDQogc3RhdGljIGJvb2wgZXhmYXRfYWxsb3dfc2V0X3RpbWUoc3RydWN0IGV4
ZmF0X3NiX2luZm8gKnNiaSwgc3RydWN0IGlub2RlICppbm9kZSkNCiB7DQogCW1vZGVfdCBhbGxv
d191dGltZSA9IHNiaS0+b3B0aW9ucy5hbGxvd191dGltZTsNCkBAIC0yNTYsNyArMzMxLDcgQEAg
aW50IGV4ZmF0X3NldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50cnkg
KmRlbnRyeSwNCiANCiAJaWYgKChhdHRyLT5pYV92YWxpZCAmIEFUVFJfU0laRSkgJiYNCiAJICAg
IGF0dHItPmlhX3NpemUgPiBpX3NpemVfcmVhZChpbm9kZSkpIHsNCi0JCWVycm9yID0gZXhmYXRf
Y29udF9leHBhbmQoaW5vZGUsIGF0dHItPmlhX3NpemUsIElTX1NZTkMoaW5vZGUpKTsNCisJCWVy
cm9yID0gZXhmYXRfY29udF9leHBhbmQoaW5vZGUsIGF0dHItPmlhX3NpemUpOw0KIAkJaWYgKGVy
cm9yIHx8IGF0dHItPmlhX3ZhbGlkID09IEFUVFJfU0laRSkNCiAJCQlyZXR1cm4gZXJyb3I7DQog
CQlhdHRyLT5pYV92YWxpZCAmPSB+QVRUUl9TSVpFOw0KQEAgLTQ0NCw3ICs1MTksNyBAQCBzdGF0
aWMgc3NpemVfdCBleGZhdF9maWxlX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1
Y3QgaW92X2l0ZXIgKml0ZXIpDQogCQlnb3RvIHVubG9jazsNCiANCiAJaWYgKHBvcyArIGNvdW50
ID4gc2l6ZSkgew0KLQkJcmV0ID0gZXhmYXRfY29udF9leHBhbmQoaW5vZGUsIHBvcyArIGNvdW50
LCBmYWxzZSk7DQorCQlyZXQgPSBleGZhdF9leHBhbmRfYW5kX3plcm8oaW5vZGUsIHBvcyArIGNv
dW50LCBmYWxzZSk7DQogCQlpZiAocmV0IDwgMCkNCiAJCQlnb3RvIHVubG9jazsNCiAJfQ0KLS0g
DQoyLjI1LjENCg==
