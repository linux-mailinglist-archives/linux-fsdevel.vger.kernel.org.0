Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865B7B505C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbjJBKdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjJBKdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:33:00 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B8A6;
        Mon,  2 Oct 2023 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696242778; x=1727778778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8HUlqAdsCMQyRgi5D8FQ1KbrOmb9WEgI4UXtkV/eXI4=;
  b=qNlLy9ZmxIw72xF/4Epg3Ls+GYblesa6ppCXiROsnyPFiTD+KUrGb938
   FDIibioKWqwIo4NgIWoCmSiN07rdeEot18LNsFRrfHNeac5dO6wU8bwBX
   h6vY4MIAJ/rKnF7/DqKvjdlvSuogLGasDffil7jPcHyMFlALqgObk28cw
   Fw5pKoBND7AcSiPGYznIpLzrNXBx9mQlDVlzVFSPfvHQ26HzMSoVZ3mej
   uoEuIOcYwIbji2nvqaHW4SOXRZuuhyIRjzvXd/CPHYsdOtDO2nBb82at2
   cDigjlp+Vwj3nVns/gwW0IefquPGRr2D5wTcskLYkSAtEr2NUUUxnKnTg
   Q==;
X-CSE-ConnectionGUID: xGJ+1MG6S+iqr+R0jArGaA==
X-CSE-MsgGUID: 53+IpREhQ/Sotqfxjn52Sw==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245440510"
Received: from mail-sn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 18:32:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcRl6vTUFbJdxcl2QEtTDVk6C0Ci000+HqNMsultd8MeLV29Eem+c6/eZboFrvT0K+RRhXsVv8RiCqTJqu2+ZwL+5M5URvLJlvuTphSRIGqO1aIh9llT6h5mZp5/pJgC8H7Gh5NAttjWWrieUYKe4DCYfmYUblS/owOBrj09jN4WO9hmXJ7BM1kjsz91h5bSaG9xb4ogwNZyo4exbxYugXW08nQLcea1idTyd/kqbLYyaMZWR+8wIFZ2HFAu16c1tekr8VRXZsqHTb8Aj/hZKX+3LNfJHzvpjt23HaWIKjI6Wn0ghxe06MLKUGpiW7HjifcV03re/syRu5Mda1b41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HUlqAdsCMQyRgi5D8FQ1KbrOmb9WEgI4UXtkV/eXI4=;
 b=cNU1Nzo7P/wwqz/3bVuPJU7AlqRuAxp1zJWqAbG8HXX4qfUHhzDKjCOTDF/syoPo873kCao/ewi+V4nzhBympVbWbdcA5CWIDD2dQPU6h7oA55X1zSGwef/o86ABDuAdZXw+zTQbJ4oZ7M0sasfBB4xdRLJLvJofcRGI4hMiUFwEA0de2T22iv4XPwmW7nlmcltczLWwaZKVpV0j5MGthuju27myrLSB2jN2+IZYxzurzw0npcWHQahNi/mJ7PwU5ApXIJFC1yEmfJ2ifISCdK1esJtDEWSprjJy0o0+3Hk0PLxfemARydLXCWAo8i4m+Lmp5+a2Lm96kUoXBSyF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HUlqAdsCMQyRgi5D8FQ1KbrOmb9WEgI4UXtkV/eXI4=;
 b=vOCkmOz2Cc+WqQmAqnG//d8wWKZ+h7sgcEz9dQuD5U+gpPz+5DML/Bf86IpWRDe8pQz815sU4rMb/BtI1nKAJhqfw8sDV/7rLerJpn+yo7dAF0Tm88Aw2o5hjOFsD67hNT9Do2EkCYkdSyIiGR7DYPUtERpFzOih9KRhbbTF3uc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7757.namprd04.prod.outlook.com (2603:10b6:a03:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11; Mon, 2 Oct
 2023 10:32:55 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 10:32:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: RE: [PATCH 01/13] fs/f2fs: Restore the whint_mode mount option
Thread-Topic: [PATCH 01/13] fs/f2fs: Restore the whint_mode mount option
Thread-Index: AQHZ6/bsbTFCjqb0LUu2mGCoJ91B/bA2X4Gg
Date:   Mon, 2 Oct 2023 10:32:54 +0000
Message-ID: <DM6PR04MB65759B5057139A8CDDE8DDBDFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-2-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7757:EE_
x-ms-office365-filtering-correlation-id: aba0964d-c3b3-4c31-13c0-08dbc332f02d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SmK2Z38uRZrDPLxs5mAgRiF4lmtTfWdNoKK9vcSj7BEN0Qbukoeu43hrSDYdhrQtH4Eg0u5icw8bMmSgviP0UuJm7Pywq9n5ASuMfTEShd1IOMeLmrZ+XhUsP0JXLWYlCOX+iLL6SNu/BuC2AzCRZVANMhb68lV2/jN1HJlYnLFR+HSsj1/ypCZUr6RgPKjhMSe4AP+KDWG3UG1UVbrszv3++hHWHdVKBw98rjL714y0i7ShR9IV3fShjNrCB25b54TuV3FesgExYXrRXXyPPH23+3sURFVwjgbOvApEanMESaZ42H82yYgDCVn9HJNBdX7tDemNc0xTmPZkMxWlSpuK/46nkYmvxoyn23LM7OnWN9W9TwUSZ5sbaMRWKsEPyKIaLGim5w0TI7/3sBrY8k0RKO9ZwRdcpTALPYrYEZlSefU72K2NpjulZ1f2SUz8LBjYB23yL60HrhgvbyNPCukWXHl09TId/t3pUxbR09+opSgARMzNG+rrbSh8NA2zlQlfKfv9AvniauoMZQScJTVzzf1yzDvrF2u6b/EoboYBzUCIQby7y6akQlUMqhil7YqlJA+0057vk3sJ9+vjYhZe1aQuoAMStg/7Hs8D5mDH6EuX/cl+hHTl7RkNsQD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66946007)(76116006)(316002)(54906003)(110136005)(7416002)(66446008)(64756008)(66476007)(66556008)(55016003)(83380400001)(5660300002)(2906002)(8936002)(4326008)(478600001)(41300700001)(52536014)(8676002)(6506007)(7696005)(9686003)(71200400001)(26005)(82960400001)(38100700002)(558084003)(33656002)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fyyGsDse2EWj4PVJEDMVbUioKjljG9QmWqr6QRSwCQB+og4fJ/AxxHTHTmpS?=
 =?us-ascii?Q?pwEyxGvkcMACEHwXCTG0Zn/ZjT5AYLeb3HRQMKa6L6a7EH0DeeCyV82qtv54?=
 =?us-ascii?Q?pi3acC8wQzo3nq9xWZwsWKEkeKJkze7NFVw6Jobxnz7fT6ct2EzY+Pwcfc8c?=
 =?us-ascii?Q?T17d/0ldbasy5cswquFZ8qur6zkWiiTerkQV3sxRGKsigPnaOo67NGz0qJo5?=
 =?us-ascii?Q?2KDNvxwzkwJ6KfEsCitlNjSr4wqUOslj6G0PmSHCwvBTvscO0tEtSa2jU8mm?=
 =?us-ascii?Q?kcz6liS/zjz3KDpWeuOFRpOqemZ7wHjhZIiGt67+J6xxuMVTz2ULshdCLrmA?=
 =?us-ascii?Q?tSZHrN4AEbuiIt/TwQ/lGQMwShefMsK+mJqV42YDhsIktzjT1G3QH3/PIB1e?=
 =?us-ascii?Q?JdigZZxqe1CGhpLIZwtUFKQdS0RDpCf6MOXocoRCUKn9+i2bAdTAXmNDtOm2?=
 =?us-ascii?Q?mz5oBs5CfxNZUS2S7TPgjwr/4NY8bAq3KUjrQETXbOX2JzBDNCloAh7/K+/9?=
 =?us-ascii?Q?y7YdzZDynpvBpocdu7ITOml+E1qu8ViDcLBtmU4ZmxADncuVWat4Btt4YZ49?=
 =?us-ascii?Q?UpUT1DIIjdnXDZG32Kd5rrAirSloowky4BnevZGEmp9AzthYAouzZUqKmMGl?=
 =?us-ascii?Q?zI2BImdMTXfr9DIxsxB7zfG3w9K7Bhw99mmNEylwXT6poQkVImEubVRr81Da?=
 =?us-ascii?Q?EKrUOH8D0Q4qzGDPrIXp9OPLqpG8KV9y9IEsAjRmVXEbEVu4Nj8P6qoOrJwk?=
 =?us-ascii?Q?ASegHgGxrw4cVK8uYf0TeX3A8R+Xn2ECHaWXHfa033YH+4N3hJOUxID6ahA+?=
 =?us-ascii?Q?ZqzZUARk4ad3wJyEWj0w43B+JisAnTbCG455d1Oe+rHNi70ddog0fGW79tVv?=
 =?us-ascii?Q?/lt6s5iOt8T9zJd8/wUDyUiMNE8iXaNxlHXBnbBwJN80MBVio+DzcO1A2EcF?=
 =?us-ascii?Q?ojN+dtH9JCaqkqOrOkcG8swaIZZ4iNM3p4JPyknLx5AiBrLa8q3VWAB5LLRz?=
 =?us-ascii?Q?F9QM331IT32GYr/IxxcaT4wZQqTbawsBmZYlISMKePDBCEeayP7jjmwqS+NO?=
 =?us-ascii?Q?egSPBcViYllNNt229+kJjo5Cp4N9HX3SffEUX3DeJMob/6WyOoxXC1AJARZV?=
 =?us-ascii?Q?HAw5ieOMhq2h0oa242IhWsOGydbyLvvPkHuw6Tm4G8sM6C9N2dZe/t4s2f+Q?=
 =?us-ascii?Q?Q0XAO0ba33kvwnI7fCmnOqtb06wjjuvnmYAEXTojyVm0G04lu8Wa6gdMKULc?=
 =?us-ascii?Q?c8NwXXTSK1ldkLCI+bd+UEfVWzLi+e/n1dJ/xElhkBZQeuRfYzA97dqy4ZH4?=
 =?us-ascii?Q?cP3RklItUTlwdAKRhrhLBtpybhwyMXqUkv/ldJrH05gZq4We1aB+T+5UNlGi?=
 =?us-ascii?Q?PMWHQojb48AChab4QMNPRRudyqaiKHU4/lVYSckNOJxZgUUEegPq0HuPYygL?=
 =?us-ascii?Q?T8sN+CfpIssnMsDp9tkjdrFlXyjo/mqR5fPr4xX/BTs+0dk/0rKSxdWXOJ1n?=
 =?us-ascii?Q?cIM+N6uJGu9tHq68o5YM8+QL+dcIguC3vt1bnL2BVMoRrwj6HLgZZI68uxo/?=
 =?us-ascii?Q?C9iXVWLcrKXjBURAtPtdl1sPFyJhBDZTBCOiUWOk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QJX+4wiyeCMfOhHdxB2jYuwENjadky+4g/ctPN16y6qFtbBgnvRNTVtXRMP1?=
 =?us-ascii?Q?5AxUu71JSCrzFn5v35B68nZHNImMhzRlc/imZvE6UNne7zz42T5IEqYTqsRk?=
 =?us-ascii?Q?8PgNLhJduAymxzPL9p2JQVCp1uKXNjjNvQNgycv+lV5I04t2PMmKYR4hysUM?=
 =?us-ascii?Q?QES42FTtenSZt4v/rla5a60yE3UNYW6V7HIcBC6LnN6dnp6lqvXISQfVLWGF?=
 =?us-ascii?Q?0mDJbNfIaluJkfsieo8jiURXEQRwHLNKvVDfcMauG3sDMu102Xzpd5TiYc/0?=
 =?us-ascii?Q?xW3+URfRPcLVeptQQDSpu+DA2xA7KdFCwBK3PfNsV4+GfucQryiElt5fcABP?=
 =?us-ascii?Q?zb6U03hbP5kYR8MTWMN6V6oD5Ys/fuJEOkIRyBm+z1D3q/sVxUTx+39g4hTD?=
 =?us-ascii?Q?f4AQuU27atoRUvS8YVMk787bA5v2qu9Jm2bcXzzkv/3COz00pprv2C0fzyHG?=
 =?us-ascii?Q?U0Kc9gUp0DI58G15RCS/8lREtZNsou1MgBL8s2ec783OEAYCiiD3577M5uOu?=
 =?us-ascii?Q?2OtnrLcBbpI3bL+E5U8BM0RyWzkwEAl5B04k2QNh/JIf4MfDFYX12RmuzOvC?=
 =?us-ascii?Q?YBJWjGPlbTnvbhLaI9+zPd/XCLxWmzTqLg9U2asKz68974SgwfqtvPHOow/t?=
 =?us-ascii?Q?2IzrYXPMRQNM48sPwNIMZtSdLO06yPljXoeNct63DyK6hL50eoXjsm25s1US?=
 =?us-ascii?Q?EfO4d1Qp/LEGG8ZtQpsu/V4w19JymQ4BzRIkS82u1s6iYFnQ+O98E7MGCKkY?=
 =?us-ascii?Q?ZAQBCD23V5GdrXeLsoYNxSBrErq6wXUnoBLTBddF2gUU/aA/uq0PUbl5lkRs?=
 =?us-ascii?Q?BZKCJWnzYe2BQX+NduEk6abbmUlK29u4FepheloqW7zdjJfKspYjOTNExDWu?=
 =?us-ascii?Q?3kQWBw3u7e+szZAf/xTYoWZGcmzRA7VeneEb4wwtXk4KXMwaMKI5kt9icdp4?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba0964d-c3b3-4c31-13c0-08dbc332f02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 10:32:54.8129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjgzSxsm0DJrDnrLwUf+jXGkusBbJW6kXB4EXAcGqx5oMJ2zHN4ugwtOAYQGR7A407CDJAMEbH74VEASn9/A+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7757
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Restore support for the whint_mode mount option by reverting commit
> 930e2607638d ("f2fs: remove obsolete whint_mode").
>=20
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
