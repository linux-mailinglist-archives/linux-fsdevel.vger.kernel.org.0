Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E430731FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbjFOSMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFOSMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:12:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC5CD;
        Thu, 15 Jun 2023 11:12:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJ4tV026584;
        Thu, 15 Jun 2023 18:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zuX53oVWijaF4/N6lJXRa6ZCtecOF6CloGT7WqopEMM=;
 b=vzZ59x9dfA24KGcTHAWfzfeCbWZ60IrrVCmE4nk2AmglThkpVbp0Xq4aFnNBSR+kTHxY
 iiJxKSHBxCM8x9Lhn3RExdvAjh4Pj2XwXM6pcU9YKeHe3y6JZeWrocNhYkubETBEJGQG
 YGtu6Y0aVo+2q+afPc4lrfjdm0EV4aw7X4N+3gpXilP0bp5h5biVfGcuQZGY4yvMhoqU
 kQp+SfMTA6k0XjT/Kdsb2pEO6NETrs+Z4FAP8XdUQpfv2MWZF58YGyNflGVW9z1xL03/
 I+aXN6ijCRMuz4ud3tLSAD5+rKwXT9IEJGLUD3uwOW7dERE4vAQ9r79RiOlDzjvcZfaN 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7daq30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:12:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGaZ4J040464;
        Thu, 15 Jun 2023 18:12:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm70epf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMVRRYGZ1YrdimPqA8v80Je7HyWxMWcEc/ppJ/jqBb0OKKzQuIsk/RclMFYugGudrb607/TRlGVSPiZvPJm/nUTmn62oyq2Dkj6CpiS3mIzSLVKFH0A6nizGUK6ci/ZD/v7fLccqKWO2Fs23CdwGKQ6npG+GmkWpnV9CKMINxkU84NvnhzUMSxpnUXIlv9Ztxf7ogVETqrchBnNVHBW6IRo4WIROPFwA7QDv1RyT7FtYfXVZW7J0xo07tm7kaAMkgg6KzD27+PeYYAvcTWlugJ4wiWYzBtSZ5zyLmdAxCPB0UuiU8EJR6CyMmCI8VOjR1ayLKxshRgJ0ZhXl8QmgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuX53oVWijaF4/N6lJXRa6ZCtecOF6CloGT7WqopEMM=;
 b=LW1C1L5BzyvS349xcXCiYcFQvlH+RH1bmCRuMP11uKaqirvyb/vNq30cdcJUd5ABK3huDDy5RdhKLEXgdoEVWasevNj2AGevkma2IMI5Vp4j1IuB5ns6HaGo9Wlp/Rw27/oLyKh/5s8mlBtKeBS6q+vPNzbzRHo+4VQXzBCIXl1kITx+rI86YicqNHUy1BXU+qArXxa2b+k0F1YZRm2k6xEbFdTdQVhVNzRlaVmrsp/Xx10/h41mLGNV5/8lNmktUaMmle3zd6m/0tuM3lhV9WxtyA7lYryCDnblenkYwa0Z8Uwv+gGmkwZ58nPryAtttMrk0De/kF6MvT1x32YwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuX53oVWijaF4/N6lJXRa6ZCtecOF6CloGT7WqopEMM=;
 b=topCaE2DqG0aKDy5PUBQ9mshzCBFGqFVB6vYpmI8S7bIAYTUVC2afZrhzx2AYd+trvdD0k+DzdT6qq7Yccxyt9SHjh+3YPREmQfyn+104mnIK0Kqsx5S43BILEw9FDUvcDB41AGW3S8S40AYFQ1DfopBB7ZDQGiueYAeNTox6U4=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:12:01 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:12:01 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] md-bitmap: use %pD to print the file name in
 md_bitmap_file_kick
Thread-Topic: [PATCH 03/11] md-bitmap: use %pD to print the file name in
 md_bitmap_file_kick
Thread-Index: AQHZn1WzHYX3ejbPx0GxRTkqNMXuy6+MKxKA
Date:   Thu, 15 Jun 2023 18:12:00 +0000
Message-ID: <E7F76124-F158-4A06-9177-3BB0B00C1544@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-4-hch@lst.de>
In-Reply-To: <20230615064840.629492-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|PH0PR10MB4519:EE_
x-ms-office365-filtering-correlation-id: 2f916a4c-dbca-4a1e-dd1c-08db6dcc03f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: isj4J/Wyv5kGmfstj6UjRR9W+KLeayZeORrQZ0KTR8mxXPxzYqFPqodooxHiRQjIfYfxwS7QW46S8GWzcDQbZQjxKpMLBgX84XMfQX1HRsMN56y0G2/veXNW+3Okq0HudaVl5NNWkaB6tOGn9vtDBaiZDA0lrT3LeNQsL4wfDja+nqitKpXgPQMZSe8gLxcRPtPbQe82bvL45wo7KxIsY5qFUVZQ2Ij/6tMqJgP1RMp7r48WQR388Wr9c4l3pPcWgVp2FicUJSWN0rJ6iJXz8SRAPiefvwEyopShBmVeHdBr6J27zoArwlXK/iKEACMIBEHAQFnY4jnayYb3sOgkCOe2W8ZO8PCJXWFZm0FwTOk84C6bSI8ThVzUHX+4xEk08hLLXcPW7zaSlxwfoYX1eWOXlolcNA9yc8LQndkjdUNZDt9NyHqBvNRG57uLWyF0aTih2Y8kHlC0hFASv4P2B54P3oza+KmM8Q+pITBuqP7m83ahUn+3QkofERmfnSMMakNqD91IZiKBzHxr+++/7TFQSgJIdSpFP29mjCSUfUoR/Vp5G1QoMVwRA/87yRs9/QDDPWdEg0hlZ3QJZYHlVBfnqXSvWUxCzqF6jppvSSLgg+2oy2H+SGA4DddrNGsuGr6JeuPicDJLLB7qgO/BaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(4326008)(6916009)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(316002)(36756003)(54906003)(186003)(86362001)(53546011)(26005)(6512007)(38070700005)(6506007)(33656002)(6486002)(71200400001)(478600001)(38100700002)(2616005)(122000001)(83380400001)(44832011)(8936002)(2906002)(5660300002)(8676002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/kX4xIccAQ39WYWObTbGOGNKgWXe4GSwkJeHFQAdYlCv517ig6HZIWuxa2y?=
 =?us-ascii?Q?imZUaa1tKKM8i0oWgTamrcLUyBiV0a/c0538imJzQuHbD14DbpqL/NlLi/w2?=
 =?us-ascii?Q?5PtzJ1wBzuJs752Rh1M6psJJw1as2PtSRTC61Czopv9sQPjk5WG402JaRPc8?=
 =?us-ascii?Q?KGf624m1LWcvTVanyB3jXz5WjnQohdGkyV5/nEkYdIeX5F9HKOVLybjFIP+A?=
 =?us-ascii?Q?iNqbKzzGOSx7h3yUv3JTSrD9Ue7aLeTKXJB2oOLxtH559ZAt8eH8eDsaLbFZ?=
 =?us-ascii?Q?cq7zfwvAAfk4aSC1sOaM34D7BkPf3YfTolPWTKiji0Muvyf6HU6cQZeFGy3o?=
 =?us-ascii?Q?qtlJncUYzASmmYvDwv2/pD9cFXWkpB9DuZJPIj2bcY70vzDzSEhhL5ot4ZYx?=
 =?us-ascii?Q?X8irXq7dawTZMOcqyBZoKYB+yggbIiQ0msDIgwTREqfIfohK+Zmild+ZPhdU?=
 =?us-ascii?Q?x0C63j9mdU0khvRnyETD3E4brqh1jvAZuxTZYxT18wV0TYQADarY96gydufw?=
 =?us-ascii?Q?5oI+yP2/xskX8Y6fxueSM1/JTrwffDKYTgHTSdsrSI+hK8eeyltxfDfMr7pa?=
 =?us-ascii?Q?W4dpP1W1XxeSVTMaaOWoQoRDleljkB51L+ocKsbQpDI2Xkp/8nQkPdYkz3zs?=
 =?us-ascii?Q?JPHTdF+rY7lHh70DyU1j742xqz1nR/1Ctm28fBWcWNhmsptNp48fyJ/8Cpwd?=
 =?us-ascii?Q?6Rb0CnEPfJ02aLDTJtIx65Wk1h/s5mbbYYjzXiyhe26g4Cj69AoJ62ituyOd?=
 =?us-ascii?Q?joZeHhSHa9DYN1fOvZPUSCMavRt1lH44XIzHbKbnCOrwX666+ABdAM4qfwR3?=
 =?us-ascii?Q?zSm7bLmGm/kTb+eYCYfDS/8syZDXb5AHM6XYqdcSzKtGywU1WxNHySYUp2QH?=
 =?us-ascii?Q?p3Eg0kEqn+VO0ZNAHL6wWDxzv/cbkx5XgOPwV13SAHJFZo34yxWLrkTM3y9c?=
 =?us-ascii?Q?J/s7cpkguGLmrk0ISAnxRAsr7Q6Ppw9QG7HWpgyj7DC+QZ8ck1BF16EvuSyk?=
 =?us-ascii?Q?JMR6mI5MhC7VdVYsmgVnO4ubrjRNaTKc3XxpBd211Zn3Lik444ZYTi6bU7Er?=
 =?us-ascii?Q?2E05EdoDNZPHTsEJATaYvmxRHIip+OF7FD6AnkBpre2R9cp98Wa86slQKSWi?=
 =?us-ascii?Q?aiCxBMklzIMqRTBND9IYYx5BcyRkPL/1MHepe7qJF+k+bOBQbI/EXrsGjNeC?=
 =?us-ascii?Q?AP8JgXAyaJ7d9C+bKtug8WsAxkDW+Zb4DQLQ4pNkASh5HF2X0o5hXgfxih7p?=
 =?us-ascii?Q?zUNbBSWFtaW0gYDU+d/Z9dWIjVxKLnHfU/lYwYtf39rfoyTHUbNGPsWV+9hQ?=
 =?us-ascii?Q?5b5Q6xIWhvI77csKYEB6fYbq73TWHuHwO5rwzsgOKyGbRIoGTtu8KRUY4416?=
 =?us-ascii?Q?Tz/wlAG5ESRJN2WCDyUfrZGaHDXI2FSKaceyov0yeg7JZv3sLkqk+v0vWnQM?=
 =?us-ascii?Q?bPKiIYnun/M339NISFsutPtKqo4V3RO6WV3eIswWZ6CVq36GyhkaPmhqTvK9?=
 =?us-ascii?Q?GAsBQBlGIvJWppifE63BlIQCUQHNXGrNBaPXoOqDjYYst93WZ6rIfIwo+mvL?=
 =?us-ascii?Q?C9BOnRQR9+ycc51EiBb8PeWHfMmr6vYpMOZiLchzgp0oW9cNFAh1/c+7ruxQ?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F6F99106660EB40BCA364B8EF81CD3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /43+5uLhu8///Ppie38YR/HmJsN3lzsNlg17r0sbxjhHvYPODWkwjZFsKRuAMh6D8frKwbOkxjn8Omq5tkoJjx1d/C8a5xsfUtTvUBLW4BbXTUCp4fe+UysgmR0d7mXGkSPOwJPeqXNM2dil+gZn5cAP9X4o6/f32bntfboUEUSi36zIoZIv/xW5x2cVgVFIUI3RUhS0uoQlnsuzSFxqGiuEKdt/NkSFw12s82yOdll+h0pXufWFBzBqq1GFMiRY2GqhAbF0pCZqh5/38UdWEs4cIxjLL1cg+kYvJlh1cJNMhA3V2uzJFqWfSqEmtYq4QUifLTR+6Tzb+9ql7xXvSa0FX7IsbxvqAijcvqZuim3T+5uJNHBZAqj57RRcO+EJUsqOk1WYQ/cQxE3PKnDTqR01K+Q3Sg5fvzLX9lu/chlYuFbT6TFm8CUGEP1hZIEFDR3Kue/7nZ4DFUeJXabeQROvtTkfcTFIRUN46lAHviPmM5YW8tg8hznOb+UgV/AmfITSWUr02jnm6k5fTBBagtFYNf76dvACQRxGTEyp2hON97zGVXy5t3ZoGAUz3d4W6qOn/ZskB6LvvZeKPL3aFeMRpjkm9ip5axjockXbv3+5LLLjHL10dTwFmKduIdpi4ykffczNmV2iwbP3unYV/nQHHi1oAfva0JjCm9CVyEtPPexW4u4KGZbQMA/rtroS08/QmL38fsIOwInqEwBDd8pXn8tCWkSjzjt2H4AQJoFVxfIkIR3JD4VqMROPQdKxQpHfJVcpbzXzpxDj7L4Y1m3vAovVxUNGY20UckVXczlNtPb3dKsZpR6tjnbUJg6G
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f916a4c-dbca-4a1e-dd1c-08db6dcc03f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:12:00.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +U+kX80a9L6u1hRzE5Qr5zPeoVN+umIG6bajAdmIN4VVoH8YnH68vF8xim7XikBvOXcI9fVeD1ORavxEGnPY6S+Z2tDZVubtPtu65EbbNuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_14,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=983 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150156
X-Proofpoint-ORIG-GUID: kmZpp1ZGam9dxhhNvLEDAcasSktrge0Q
X-Proofpoint-GUID: kmZpp1ZGam9dxhhNvLEDAcasSktrge0Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 14, 2023, at 11:48 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Don't bother allocating an extra buffer in the I/O failure handler and
> instead use the printk built-in format to print the last 4 path name
> components.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 12 ++----------
> 1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 0b2d8933cbc75e..e4b466522d4e74 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -870,21 +870,13 @@ static void md_bitmap_file_unmap(struct bitmap_stor=
age *store)
>  */
> static void md_bitmap_file_kick(struct bitmap *bitmap)
> {
> - char *path, *ptr =3D NULL;
> -
> if (!test_and_set_bit(BITMAP_STALE, &bitmap->flags)) {
> md_bitmap_update_sb(bitmap);
>=20
> if (bitmap->storage.file) {
> - path =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> - if (path)
> - ptr =3D file_path(bitmap->storage.file,
> -     path, PAGE_SIZE);
> -
> - pr_warn("%s: kicking failed bitmap file %s from array!\n",
> - bmname(bitmap), IS_ERR(ptr) ? "" : ptr);
> + pr_warn("%s: kicking failed bitmap file %pD4 from array!\n",
> + bmname(bitmap), bitmap->storage.file);
>=20
> - kfree(path);
> } else
> pr_warn("%s: disabling internal bitmap due to errors\n",
> bmname(bitmap));
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

