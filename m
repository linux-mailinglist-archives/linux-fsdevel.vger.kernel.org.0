Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DCB73FD51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjF0OFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0OFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:05:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90610296A
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:05:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RCdK23030667;
        Tue, 27 Jun 2023 14:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SKAk5B0FaztBg7dOfP5s5BihO/dwAN9q87lsSrx22vk=;
 b=YQVuFBB7+vOH81FW8roKTYQkzUAzOgJhXpdtIL1ybmjfYZ5rhVQoVgB0c8L+JiGpw7d8
 DTmTfSasF6JfC+zsLr5fnDrMdi9YHeohADmgg28pqTf6IrvMEwV7DaccwvRkK38oKC3b
 233KuAvRrvSZcywIYyIYyWikoaCCweoMnzUfQBsNjOJwFpvghcqloNV9Z1M1o1v0xEWV
 WqorxJR45xrmkwO47OKLGX+LmXNIffX3BgN5owr1n9YwVdFaXJlBT4J5nO+CA7lKg403
 175kVJZy/t+jW7TCn0feidk6A8FtZ8oY9552+9zAZQ6UXSnuS7zTJ8/48dy9/WT3I+ZW eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca4u5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:04:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDVdiT013086;
        Tue, 27 Jun 2023 14:04:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx4sm0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOSYNzMYh5VgoKnZmWcLj9tWKvYY4hq7VqfGK4RBV5fiaVLMi+a9NVJnNSIwFdiyaaB2eaAIAkS+fsmnVDLbnesGpPzreeMvi9pRhdri8Yi6k3XAm9XxdY4+dnVCh6OujJwl2fkAY1w4UtMQyIOpEbnENAE5UuraCNSG91RPlGvaS+7vsaVOjg67F1vmZmMysdVmYMgrY3e71YDhR9/5x9eZSiG1GnFN+ScAD0Ni/e7vo5Z3Ijgct6Sw48EkIwWa38zXGyDQLQTQ3xLg/HneAs4A/PhZO+OKxaoAoSwVU4Lm4rake8JMpjswuO63EY3gmtZOTtkLXiEdMfc4A9HuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKAk5B0FaztBg7dOfP5s5BihO/dwAN9q87lsSrx22vk=;
 b=ca3PLDTdeBZA50ofiwHktUctm/BbVtVEtOTlTFYJQwBaEfCog5FnXfT/5QGYMG54ZL5Wf90nfNe1haHdNBKOJ3iQLaBIZ6oSIE9hAkC2Lp4gfr6fvdcvvhPurDm8vytFfj6UMgN8bLQaUsdRGKqzqxK4HVdMCmBH2LW0xu5L2+2K3SbaFbCv1wgnJLpNp4/LbIqTtq2pix1RTsteM47qNVWaB2wPguuyTYcD7raFNSn2xQAMferhHWm7Jh6DvO6igAcwzFyYbUggkqO/hLqYUCnLZFgV+lzKLelEI6eCiSk/DMsBQkmHQsRURLvOd+J+9I0HUptxq/RIjOzS+n6G9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKAk5B0FaztBg7dOfP5s5BihO/dwAN9q87lsSrx22vk=;
 b=k3411rfmjHpMd/p2LoH6xTfNT0HufEAkdNOHnn6LqX2jz4Y0qCqB5ZX4IqQYTBGal7OZKmDv2Q+1OJ3Z/fcXIsGOANEfieyZ7Zk3CGibFR+Eafy9czRuKU0+k9Q+sNimvRRxiWdv+J9tJRI1gtZEkuJKWyFBQNltzvzSRTrW3eU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 14:04:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.012; Tue, 27 Jun 2023
 14:04:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <cel@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] libfs: Add directory operations for stable offsets
Thread-Topic: [PATCH v4 1/3] libfs: Add directory operations for stable
 offsets
Thread-Index: AQHZqFsJLZ3qEENLdUWUr0wmJyMdra+eNN2AgAAjygCAAFc8AA==
Date:   Tue, 27 Jun 2023 14:04:44 +0000
Message-ID: <61C84AD6-EB8E-49D5-BDB1-F87D3D5558B7@oracle.com>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
 <168780368739.2142.1909222585425739373.stgit@manet.1015granger.net>
 <ZJqFP8W1JmWZ0FHy@infradead.org>
 <20230627-drastisch-wiegt-8d2aba4e5a0d@brauner>
In-Reply-To: <20230627-drastisch-wiegt-8d2aba4e5a0d@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4132:EE_
x-ms-office365-filtering-correlation-id: c9b14cfb-c7e4-4fc1-dee3-08db771775f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUZ9isHGhu9/MUZIyHqpHg7HCaGVLkKRMoCubFkZdq/3bY/y1SpK7W0rLShaz1P+X+gnL0QqZ+Chxg0ScEAl9LysSob+xGsZqml99xfuxwEK2bPJt78ma8beGBVdY8ZJkKigjn+GvGeqAmkvfBPxItSRZRAD1iCgFODkLKwPe086sAEUFwJxNQ98HPJ7F5vedvN195F4Czez88/xLhXM1HkPey3Sm9jcHfjfIJoUmNnQM9KLPB4HfOMChAAsClePy7AKLjpZglDXd+dF0YwLmMUErF4gHXz2wrdZ8+Li63fSCIfb0J7ehf1Y/xaMazRSdRPrFFtpWNbxyPKVrl8tpJdmf2gn4KeCJuEcBW9Yr41nA6tEKSXPuPNGbEBfHNyGgHue+p++LM3kLrPuw9qFtUsItnW4EbUs6VMupj6OhzLslnXmu5u2jIzxixagw+tyD+2clnd0VjpDxKrshba7cZekhY5LIMUEgFrbx2T8OtfyGfSDXRefNtPdEqx6C5qKsgpmKdsYBhcfvKcLrGZx/gljBdOhd2fa+jYT4rJCI6LTChWslP2dqto+pvKBLeiFGSesBRgvWPszvAooiT7nEyf3jRowvpMjwVjHqdQqboNxQbnS5t8mBge4Kr8WnkhkvxjaplQCB4w95Vk5cU5fRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(54906003)(2906002)(6486002)(38100700002)(122000001)(2616005)(83380400001)(71200400001)(26005)(6506007)(186003)(53546011)(86362001)(41300700001)(478600001)(38070700005)(64756008)(91956017)(66556008)(66446008)(33656002)(6916009)(66476007)(316002)(76116006)(4326008)(36756003)(66946007)(6512007)(5660300002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?47KI/mZl27eUh4vhW2uqS2frejxo/2h0lT8SqpaEw3q7Zd30c5ydpQ6Mf35q?=
 =?us-ascii?Q?IOzNAsfuMorqWBfHvB1oRTarCmiEIeU+7O4htw/3U32k/g04GNyIWwgMSBc9?=
 =?us-ascii?Q?4taZw1Dsc0rymNwIDp7iVCPDWvEoGAfEbhZGlooOL1T1tOnjfDCGlvEcaDfs?=
 =?us-ascii?Q?HyP7tQ1d8jBCISmEsgXrDT5y9ePKJOKVEg/dQVMyA1snYJOapwPrS+e8P9Qb?=
 =?us-ascii?Q?f6+XSif7NLoYT6r2v/pHJhD5/MAodT2Mc17EPZXZ6KEhGaWxorsloXFhzRyl?=
 =?us-ascii?Q?hZ9SSOlyv9nIFfUGUbOWbTJsVMcNrTRFt8qV4Ds/lZMFKRNRUkPrdMsbX0tS?=
 =?us-ascii?Q?Dwz6p67JMiP10aldWsOdVFtCwhUBgYFfVBC1vPZ8uA0yLg17V6gMxFpkkdKc?=
 =?us-ascii?Q?0Gc4tVkvhGm6kxclhZ1Rr5wdIBPbw11nb5Q/Jk35zi7zMibiDGZ19d+HY6GE?=
 =?us-ascii?Q?5T11LJUFVtnpkurtFn/STowUv+TpOpg556YtmUX/nMjxGUUxabfnpd9S/zsn?=
 =?us-ascii?Q?cHM7mQY2cxRTMMl8XLO/DIkRYtBBfFxUChwwcvSMbdnjftIJwUdFILomLEzw?=
 =?us-ascii?Q?yn2PzebX82DEo2Ww+DBG/0jGj4iM0qkWko+l1n8cWxubt1xxzmI3+Inl5Ypn?=
 =?us-ascii?Q?+IWww11z/Hf03nxbK+qb1cWNG08g4ESjFxDXiSO2ffPrqYZbOAaJwK7htUaF?=
 =?us-ascii?Q?m9Qv4e8KIjrMw1LwSMieQOiPwFziEKxzvEA5lLTlwzmiLNyKtth+z5b0czC5?=
 =?us-ascii?Q?xVk/wnjXVeI45x2z9prsrMMtXMpJNWsPKnpl8nlyg9hpmBkbnBwU7HOw7CT7?=
 =?us-ascii?Q?WmcgLT8FfkW/DGYoiymEqGAAF8g6KUnaNo9Uf7wmMKLEFR06oDP0for021La?=
 =?us-ascii?Q?xtqYsjNbEcKEhR6fK2P2WMbwyG7WPlgm2N8iWUmSUStMpHda1mn+0yVrppcb?=
 =?us-ascii?Q?Qd/erPDjEBDfX8OjdP/78Gzy05a0smRGNo2STTwHYxG2iPozrrnbHnPEpoEn?=
 =?us-ascii?Q?uL0mZnEOU8Y6KBldLAV28Wifz/ZKzOSZ8DCEy52CghctME60J+pCiLz/qW8d?=
 =?us-ascii?Q?ddF9iQ5QWMcAzElItuZpX6eEeD8NuvkSVsra9NDMSnqTOZ9vcbbOn0ee8P7i?=
 =?us-ascii?Q?xWCM5YVt7Ab2Mtl/jnuwqyFNnqm+Ny5mK6POZ0NRqa/FlVZRM6bn/MLqdPGl?=
 =?us-ascii?Q?1rJdiw/JkfImV/yc1PeSZZxn+tTMuaXNZDCxMcUETwOBVg6v/vsgJ1x8b1VZ?=
 =?us-ascii?Q?6JLgUKVp3lX5z7NlJmqvZ6vN+UdLi55z1xnFiRnopI/RuEKGWoM9177HA5Ie?=
 =?us-ascii?Q?oL4XQ0i8qA9tcRALyCy6ecyOv+6INitE5S4lTECbSGJrwco/N+A8X5/5tC45?=
 =?us-ascii?Q?u6nBmWkhuPKPKtyshEXIssL5pggnVDXMlorSX9BZzzI3VVeRILjcCK4xntLL?=
 =?us-ascii?Q?LAk6SHkESYq3eYUiXjUtnJTd3bOT8ZctLeyP9Z5AuQOGt4LcD/On4p3QMoMy?=
 =?us-ascii?Q?vUFSeMmuZ+LH5NbA5NrehHxbs93hiVjjj1BTrZD7FWI4p4KeWM5CnfL3HwRR?=
 =?us-ascii?Q?KFyNttFzMwbrOrEGuliXWYOGNrJ0vVwJ6+DPov1MdY8o4z0VvEaR9YSSYKI+?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5887BC4BAB77964E991CD82A5056E5EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PlDor8t5O6NISyCZJxNsETSzOuPa4PBPLFxPtZ08A9CXifjfCXo8vu1u5vb7?=
 =?us-ascii?Q?iycz6+f68yCsycKvmzgniOBDb+uufNWQdIW2MxBuOH2T6/tegyo8dq68Opxe?=
 =?us-ascii?Q?CoyO+0CA2kivF31cS4fNHwlpGMkU+Gg09QtYNXyEKsAbWg5TCdUa7qG4xUSg?=
 =?us-ascii?Q?pDlkaxSzjw9T+knpV/BHD+mWY/uqcdxZ+qTpt0e6FNjnrlVk2Omev9pu3yyO?=
 =?us-ascii?Q?9l9LL9MEJAgHyf2lw4FhjQF5hRiNcB812Opaz70Fti/9xFoGzQBLpGMtpvwV?=
 =?us-ascii?Q?nSfMl7zxHxXCNtxFsWlybgCDHguU1waWUnPwja7Og0N19BcoQaZDv0+FjY1q?=
 =?us-ascii?Q?37OoNKmpdJy0IJewiOX4AFRUilxawfHKlZhfmjBfZnBXDiILOedjO4YN6zCS?=
 =?us-ascii?Q?cPINKJ4yuqcErrS4iTmDtboMrIBG9tiW0YMOLBkSwNSZ/b+7WeyJNfxgh19P?=
 =?us-ascii?Q?/Cnx6xPAPzgAcjvFiGBZyjV4Xve2kfDkmb+BdV5KKYHiC2FMLqCSMQo9xkdr?=
 =?us-ascii?Q?HGdY3vLXR/yRY08EUJBq4HUXRlfHK1fOBb4QIkIzqYafu8Cpdfv5RPV052k8?=
 =?us-ascii?Q?bcRX6I8VmS1IyWzzVHaoEbXJXE/fO5atkDw47DO3rb67InojcFytZzRfrvPi?=
 =?us-ascii?Q?8scBkWGv92N2yhG24Zczj0pLYVIUaH7jtPpwKbR5WrC/x0bfAcWTU+M52BUC?=
 =?us-ascii?Q?9Yj92y6VyPvnE1th74iGgRsBdCX2FVo5ensQt/tixlw1XwV8FV5ims4Bm/gd?=
 =?us-ascii?Q?3RvGe3oAXzjloEEBOJ77t+WL6FsxB3+PdCKQoWI7UFUxG1ZKEwHa/C6rOHxY?=
 =?us-ascii?Q?q4iLjQrZsyzm4zOWH7rGJ3Tnmb2Zv3NewBzu92uVfcJxATv0VFzk2Lf1Amxn?=
 =?us-ascii?Q?QayR+ToqgWU06hKoIHKQuWLcSu+arRMEWho/VScpdGeyTNCHqC+S3UuGQN3v?=
 =?us-ascii?Q?HjSEcvVN4+8VaKSH9B3IH1DbMp99CkntqZWxwfTCK/PwSJXvHsQiVqtujAUW?=
 =?us-ascii?Q?UsAFoJv9iIfFcss8lqH2E+mzaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b14cfb-c7e4-4fc1-dee3-08db771775f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 14:04:44.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir2WeVyxtoAei9nY5Xlli8h8G/GFxoUvvNq6sVrSAEifucLmYf8bMelCKQM0a90m04qYukploiy2T9q8T85mMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=853
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270131
X-Proofpoint-ORIG-GUID: ZTFKudfhoBPuRU9EbVv27unfR71YFDk0
X-Proofpoint-GUID: ZTFKudfhoBPuRU9EbVv27unfR71YFDk0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 27, 2023, at 4:52 AM, Christian Brauner <brauner@kernel.org> wrote=
:
>=20
> On Mon, Jun 26, 2023 at 11:44:15PM -0700, Christoph Hellwig wrote:
>>> + * @dir: parent directory to be initialized
>>> + *
>>> + */
>>> +void stable_offset_init(struct inode *dir)
>>> +{
>>> + xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
>>> + dir->i_next_offset =3D 0;
>>> +}
>>> +EXPORT_SYMBOL(stable_offset_init);
>>=20
>> If this is exported I'd much prefer a EXPORT_SYMBOL_GPL.  But the only
>> user so far is shmfs, which can't be modular anyway, so I think we can
>> drop the exports.
>>=20
>>> --- a/include/linux/dcache.h
>>> +++ b/include/linux/dcache.h
>>> @@ -96,6 +96,7 @@ struct dentry {
>>> struct super_block *d_sb; /* The root of the dentry tree */
>>> unsigned long d_time; /* used by d_revalidate */
>>> void *d_fsdata; /* fs-specific data */
>>> + u32 d_offset; /* directory offset in parent */
>>>=20
>>> union {
>>> struct list_head d_lru; /* LRU list */
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 133f0640fb24..3fc2c04ed8ff 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -719,6 +719,10 @@ struct inode {
>>> #endif
>>>=20
>>> void *i_private; /* fs or device private pointer */
>>> +
>>> + /* simplefs stable directory offset tracking */
>>> + struct xarray i_doff_map;
>>> + u32 i_next_offset;
>>=20
>> We can't just increase the size of the dentry and inode for everyone
>> for something that doesn't make any sense for normal file systems.
>> This needs to move out into structures allocated by the file system
>> and embedded into or used as the private dentry/inode data.
>=20
> I agree. I prefer if this could be done on a per filesystem basis as
> well. Especially since, this is currently only useful for a single
> filesystem.
>=20
> We've tried to be very conservative in increasing inode and dentry size
> and we should continue with that.

I had thought we were going to adopt the stable offset mechanism
in more than just shmemfs. That's why we're putting it in libfs.c
after all. So this was not going to be "just for shmemfs" in the
long run.

That said, I can move the stable-offset-related inode fields back
into the shmemfs private inode struct, as it was in v2 of this
series.

For d_offset, I was (ab)using the d_fsdata field by casting the
offset value as a pointer. That's kind of ugly. Any suggestions?


--
Chuck Lever


