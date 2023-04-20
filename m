Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0626E9605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjDTNl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjDTNlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:41:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F155A9;
        Thu, 20 Apr 2023 06:41:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K80X9J020879;
        Thu, 20 Apr 2023 13:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tjd3gx9dR/WnaELz/vOZ2j+OkZFB9B+IQUC/rhR7DYg=;
 b=HtlOJxGhPXouXB1TALdn3sdrIUypI2/p1vkXn000/hUa96sXTy5SjWvr5B8CBObHGunx
 k5ygy7dEvuKC+DiE7UPpvkzAtmppb5ktTUICnvNSr6aZ2rJjuk72NAPBnzhdKQIclVJ8
 l8BVDK/0wFZPQPum2MFLf/TXv/jDxbuPZJ4mPYsl+DTKpQOyPGO4QrGaZRNxVflt+cIO
 PJa+Ir8dprqTgEddIt79olGkiPINWtuBFeXUXjPVa+zjHXxLfFc1SpbIYuin72j6oUp2
 qN7aDTl7WJLlnhj8BFQsIKj0bfLFxkL5j6BqDW+OQWGZWXQLK6AyqUwF+E2ecxu5f6bd lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu2v69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 13:41:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KCgWaB037801;
        Thu, 20 Apr 2023 13:41:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc89ehn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 13:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNoMqS1XLW6abJFV5tjqYq3aYijIznxpgIN5biMPNPMSJWmsgNVywvLsM0Bx1l+T0KkR5ZYLiCEihg8vTB5ndsrDBL1LevD5IYtQ1KbCk5MRpZhssGOq3JgbrqvGw+xpTK5QAJfQRr1eBkL5rlpOAx5i/h623nLKSFWco3WFtz0+Tlta07dDhLjrgHYKmHEOMgZfz+F/M+yXexPJulhnA12Vs4cgy2dHsmgphDwmnqVUdBgTLpzeENUrMlyR69Lt4bIhsNBG0pfZnrETsgpvrlNWSdscOpY+EBTDyuThPcK18lCAZ9FZTRXq78XtyXEkrg+0YjD6xktRM6jIDm/MSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjd3gx9dR/WnaELz/vOZ2j+OkZFB9B+IQUC/rhR7DYg=;
 b=AYw75eHebrKnpMfrgbzIHqijO+0cEcipfAbIP0i5wUYP3EqfQdp97fboyVBGjyMZBpmVeucQUpp6xRpVY+lv8CXhief7Dn/Np+KB167Bhi8OFOkW20LAs0cjDZfi5RCBwJsMPGQ2nzmXxBw3IwB5Sx5eQsfkXt0YZ62bZXAtYrk1QxDE4nd4XQ0RAfkslLCOjTtCSMzyrTI4lUQkV8mb1nisqAITZen/iGf3SvYqDINFKGsafsnd3YJ041zlxAafNBwo60FzhUtl3Mayc1TqOeJ6TpBCjVgc6W5IbM4TgMa6O6iWDfn9Z1kl7qp//uqMEOYvGHnbIOYRtmEI8m5arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjd3gx9dR/WnaELz/vOZ2j+OkZFB9B+IQUC/rhR7DYg=;
 b=jy3LWupjD6NoZ8sFJOh/FKEGqAKslai3CDa4u1A/NKY63WJFCw1SKk5HBY2cwtgpYA4E2IH7ARPrtCsdxgJvZh1O+LSOIqvDK7tXKxt671ox13hhyC0gWQo0bC29P0wuYSMSYEVvxTTKi4omsobGq8HNOOY/DnXixMinctAzeSM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 13:41:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 13:41:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Chinner <david@fromorbit.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Frank van der Linden <fvdl@google.com>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Topic: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Index: AQHZb4qhR4jn7R6+a0evVV4Y3qmRcq8si0OAgAAQUgCAABjIgIAAToKAgADRqYCAAMVVAIAEEwGAgACihoCAAO0BgA==
Date:   Thu, 20 Apr 2023 13:41:10 +0000
Message-ID: <234CFC61-2246-4ECC-9653-E4A3544A1FEA@oracle.com>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
 <20230416233758.GD447837@dread.disaster.area>
 <A23409BB-9BA1-44E5-96A8-C080B417CCB5@oracle.com>
 <20230419233243.GM447837@dread.disaster.area>
In-Reply-To: <20230419233243.GM447837@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5825:EE_
x-ms-office365-filtering-correlation-id: 2d149786-247f-4752-4342-08db41a4e6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7OGhWax/C14+FNrlkt/TuvBqC7fLji6sXYENp8Yvfjfh7uEl4DJj158Hvxcn3dK7/cSuepZPoKD93ypbiOKsEtYmSYbZBF+RkrwkHRzWdfHL/LgRqJbPpNDLpHBev9EQT3tkd4vX2fjHZFDfTnyuNTy7/OJZpOPhV5clTDHRtAzPlKCcNjubMDEX8EXGk8WJOMqHfMSSlcTpUhhIt5s8dwUfyZJKeDbfna7TMAbxDGnjjl5FlmbV0UmQNkX4ZrNWaGbSG1TEMlc9++VyhyHlAqaUprU+/m6kTM96s8AvAlpbm73PcpFSnYBL8zFQhVKUg7H1a5S6P74tUO4V91XXVK+a+6pbX/Etb24788ykptpbpS97r/k6J7H1TYsE8UzBWdhbkTy8NcQQHjFBLMkxHHkdswXGQMtI2vSBUlq/vIdURVWXZZtQp5rZqobaeLe3yVAZpLOmYHQ38NwMsKtrlcfVvbwKFxNdR0rdKwVCeBxGgu90eipDe+DPx24lN+Nz5gBfpMrvA9VsPdrDxAE2N/xItT99hSyr9e6VOnMzsTPB0rlB8r+PH4OWWHAhQYUkimeh1QhR4hswQjC8DsPOWXW3MVd4De8XsILAWre2UiNI+pvRCOKXYbUsUmMtzaZ18Qn6O1wMYoQuFzcCzUKGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(54906003)(110136005)(316002)(2616005)(83380400001)(478600001)(6486002)(71200400001)(64756008)(66446008)(122000001)(4326008)(41300700001)(66556008)(91956017)(66476007)(76116006)(66946007)(26005)(6506007)(186003)(53546011)(6512007)(5660300002)(8936002)(2906002)(38070700005)(38100700002)(33656002)(86362001)(8676002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MKvBYXjFTd/nNV9QYtkK0j1a1dRsjBjmwPame5PelOav+jFgSbOrE2TQUeAu?=
 =?us-ascii?Q?2e/iI2WOT0oyS8aB7uEUvIOIKkl0TvUT1Ul5M3Z6WL1XJK6hqFJmm4dLgmMV?=
 =?us-ascii?Q?g4sD5dGtzVuEyfakMOsStJ5fHAR30RGxJisY5rwSVY82IjWzoQZREqfbC6e2?=
 =?us-ascii?Q?7dhtgiqyAG3q6TMR6l0xBk2tsDwT+86NP8OUJftVeRs8kGCp6OiYsasP15rv?=
 =?us-ascii?Q?s+4ZPc3jVQgPcBKxYB8z4X01fiqGTw3zYhofbvjArEb3e3Xx8BlLQf/MoOi+?=
 =?us-ascii?Q?BUWt0FobO6jclvoFyj5+szL5KuBauQ43NyI+kUt4pqTBJjZeBJiHkaX8flKY?=
 =?us-ascii?Q?9bd3hsz5AUy9VYRaI/McfQa4SIuGnB48HaIOG0X8L4jceY5DSIHnlYnLr47m?=
 =?us-ascii?Q?ruwtpkyx5+6TCNn9Gw/k9dpf3I1Vt55S2VhLAEZImBzYgts+84ZQUmoqX3o7?=
 =?us-ascii?Q?tofS+EJ7yiZlKDVhRdsppE1D9riS/iCYaG7m/wTtYN/AW+C7NXl6SNn8r4nA?=
 =?us-ascii?Q?1WEFEeROvZsGMkBZqS+6utWjzwkakJLKQGoCsW6Fj4hZe7VDrIEJvr46/GJV?=
 =?us-ascii?Q?gV7jQe7Y8I4vbqtgoQ2oODpmxHd4qr/bpPBOw1GBUVoecdUYb+QgeLZYFDtx?=
 =?us-ascii?Q?Aiz3a4ccw3HNd9I40UmJI5bHAe8G7+RRrbADfJrk5030Qt6Exgeg/3C4+f2n?=
 =?us-ascii?Q?ZsPBCjXMXrLBT4YrlNh8za2Rx2exgCSSDjQppY0HSaUGCCwrj2OC1Z9i8ylp?=
 =?us-ascii?Q?BQOnV/yd7eJOGaLcUxUr79OJOLMzUvKamfkPCQxWygx2U7MbP2FZcjdEP9y5?=
 =?us-ascii?Q?bnBvJKyEIZSq8UnZXoc4c4mdQdaG6DGfWe2AKZZTNg3mlKe39xLUy+HQkxpH?=
 =?us-ascii?Q?MJNdj2cf6m+tmnBcTPF8odId27UrFJQceRGIryaq9gF4f9chsyXdxLSJgZuC?=
 =?us-ascii?Q?6W8UjHf9WNzEDLInSWh28wyYofD27sD7Q4V3eQRSPUr+o+D0lbgwesRTr1RE?=
 =?us-ascii?Q?+BFBB1WHaSBH3/xDazUlnuXKBXOAg+TkOarsNCwzXH/S+WafJdoFmrITN2/w?=
 =?us-ascii?Q?1FkEGOyg7Ia0wawOYQ3W7YXeer7zalTLse79Fe+bfI5Fecaar8FZU7AzOi5N?=
 =?us-ascii?Q?lKDQAyjhfAphaTT0xp6WMCa1CZA9FEEjkXsVEx80HgmNKtqLQZma411yFNLk?=
 =?us-ascii?Q?ONmRktIjB8qQ/A8dBnOYZ6shiAyljj8vphQrs9DVoouENhnHiBhKJUeEdUNN?=
 =?us-ascii?Q?4V2J2QTB3PQMecSun4iq8e2hf9wr3Yk01IbzKBVOOYUBBUR5tyJqKOgfqEFh?=
 =?us-ascii?Q?sAvudPRI5Vr6klYi4dPtmH7aq8HaDKrW7vNKGsEGHwCIujvx8206bzDBQVxf?=
 =?us-ascii?Q?2bhbGBEcnGXZp/PzlsiZdr3L0RkyKkiztJCgqzn8g7PqENAQsF+D3YxTSTRy?=
 =?us-ascii?Q?yPCbYZgC8djkaP1SZlKX5Hvwm+qFrb7td5mZtZmF8DcUx5VSpJv9l+tCgyBD?=
 =?us-ascii?Q?GaOo2C1GveCPgdpP7x0qgEx/K83HxACEeOSJXmc8YK62DXA1YxynOXwRXdi6?=
 =?us-ascii?Q?X19M7oOuCEpidbfy7xDvL22KFQyUo8Nzey0rBc5dpX2YDA70NnMucU/YzbYb?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <165022D0FD57494BBAA7F5D88E1A6956@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sjrsfofwj5DwAXFpbLK6Oyz43VyfEq6VGpV7JUPxWzkewH2QviUsTQzL+b0GVQkNipq6RXcMmDMcs9zPt36BtJSZCO5MHrFijQIbx2AUwURF+FajBv2AKKQD31L8etIpFvZM+ZNwnC+/0RpUMNm+gmtVouHW4BRJ3P7POY9WrJ9Mu+dfjJJ4GAmVHe2bSYc6scVKFKxGnGf4vMC8JynybyF1Zcr97YlKBLCvZ8SPvlLlppaqMIytm439TMTJ1TXG9IsRoXPGwoklfZwATbM4S/WLoIZrrzw18igFyVwntlnUqLBncncTEYeHzIVgqWvpz+R1/Zx/omfOFv0RcpScmE30wgL0eWLCvx+4JM8XGhW1HpLoyUmyMYU059lHfia/8oRsy1szqLKhKOsDAxWPzGMLcic0ZXunKLtsAfkw1Dp4aksBtte3GaW99JfGNquKosJZ9Z7QIPkSrBs3OtliXO4urCeq6oozkBV0orLDbZbdPdoHfpxAUdbB8180586pEz6WYLdPsoSdR/y6+hL0heJxs+WDhk9393O8jC8WZ/rydU4EB/ZHmYQjjL8mFPU8N1mRycrW/AHItP+ZahFp9d+cfjsRjd3Hu2op6t8VKepw7fx2QpjlUA3xwdrjB0uCaytpbuX8/c5w7V2qncUiwuj2Mz0XVkVtn2pq2Yxh/oIIhSLekAasmXQGs/3HYmpDD2ug2G266WDVYNHXDNFSREr3XTUJ828mFwTx20sZzbkkGhEgy7mSyamp8Av4hHxmzR0U828sRcRuUKacT811Tju54MkFogEUtFBiOSHciQ7L5zg+PWtjSbykZQNVezlRSHYz2CX3odPr1odSRwKRA6lCSxX5/u1PSbcsI3t4aK4Td9aGFX5gCaucvt76GA2yoTntoLlEgN9t9LWVTiO8KWckygrerP2FJm3BZg5MzUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d149786-247f-4752-4342-08db41a4e6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 13:41:10.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6K9L4gtKXsKZIJpm9yyqdvtl3dbtZYp9binjHT+KWRjms2jfdqJhSd/JGzvgt64Ln9ITy3xpDE2A9v+xXCHpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_10,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=809 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200111
X-Proofpoint-GUID: RAYE_uSGs9hu1eDugKg8qU3dd1eQlr4m
X-Proofpoint-ORIG-GUID: RAYE_uSGs9hu1eDugKg8qU3dd1eQlr4m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 19, 2023, at 7:32 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Wed, Apr 19, 2023 at 01:51:12PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Apr 16, 2023, at 7:37 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>=20
>>> On Sun, Apr 16, 2023 at 07:51:41AM -0400, Jeff Layton wrote:
>>>> On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
>>>>> On 2023/04/16 3:40, Jeff Layton wrote:
>>>>>> On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
>>>>>>> On 2023/04/16 1:13, Chuck Lever III wrote:
>>>>>>>>> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.=
SAKURA.ne.jp> wrote:
>>>>>>>>>=20
>>>>>>>>> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | =
GFP_NOFS
>>>>>>>>> does not make sense. Drop __GFP_FS flag in order to avoid deadloc=
k.
>>>>>>>>=20
>>>>>>>> The server side threads run in process context. GFP_KERNEL
>>>>>>>> is safe to use here -- as Jeff said, this code is not in
>>>>>>>> the server's reclaim path. Plenty of other call sites in
>>>>>>>> the NFS server code use GFP_KERNEL.
>>>>>>>=20
>>>>>>> GFP_KERNEL memory allocation calls filesystem's shrinker functions
>>>>>>> because of __GFP_FS flag. My understanding is
>>>>>>>=20
>>>>>>> Whether this code is in memory reclaim path or not is irrelevant.
>>>>>>> Whether memory reclaim path might hold lock or not is relevant.
>>>>>>>=20
>>>>>>> . Therefore, question is, does nfsd hold i_rwsem during memory recl=
aim path?
>>>>>>>=20
>>>>>>=20
>>>>>> No. At the time of these allocations, the i_rwsem is not held.
>>>>>=20
>>>>> Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
>>>>> via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) a=
llocation.
>>>>> That's why
>>>>>=20
>>>>> /*
>>>>> * We're holding i_rwsem - use GFP_NOFS.
>>>>> */
>>>>>=20
>>>>> is explicitly there in nfsd_listxattr() side.
>>>=20
>>> You can do GFP_KERNEL allocations holding the i_rwsem just fine.
>>> All that it requires is the caller holds a reference to the inode,
>>> and at that point inode will should skip the given inode without
>>> every locking it.
>>=20
>> This suggests that the fix is to replace "GFP_KERNEL | GFP_NOFS"
>> with "GFP_KERNEL" /and/ ensure those paths are holding an
>> appropriate inode reference.
>=20
> If the code that provided the inode to nfsd_listxattr() did not
> already have an active inode reference in the first place then there
> are much, much bigger UAF problems to worry about than simple
> memory reclaim deadlocks.
>=20
> That said, nfsd_listxattr() does:
>=20
>        dentry =3D fhp->fh_dentry;
>        inode =3D d_inode(dentry);
>        *lenp =3D 0;
>=20
>        inode_lock_shared(inode);
>=20
>        len =3D vfs_listxattr(dentry, NULL, 0);
>=20
> Given that a dentry pointing to an inode *must* hold an active
> reference to that inode, I don't see how it is possible this code
> path could be using an unreferenced inode.
>=20
> nfsd_getxattr() has a similar code fragment to obtain the inode as
> well, so same goes for that...

Dave, thanks for handling the due diligence! I was not 100% sure
about code that handles xattrs rather than the primary byte stream
of a file.

Tetsuo, you can send a v2, or just let me know and I will make
a patch to correct the GFP flags.

--
Chuck Lever


