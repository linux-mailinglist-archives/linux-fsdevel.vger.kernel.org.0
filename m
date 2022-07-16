Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3D577015
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGPQTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPQS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:18:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A464F8
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 09:18:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26G67Znv010594;
        Sat, 16 Jul 2022 16:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KTLNLW4MwTl1W7MPa3uC8xU2LcckgV9CoCb1u3LIKXo=;
 b=wtIEIf4zEnHtnZp9eT6VzE+3/2uUmnCDrZ5OiodcRnvtHA2IBanBLNgFWxDpNFn3DA+m
 WUcoLYMUWFoq3XmIoDpztWttk74NOSg5tYZQmnHDg0yPrOYkXP+shZbAlh/nHrL2/ctk
 hHOEsHh/XbhGIKGRo5HyZI92YSyc+qBlwCZxxZq0EcFtzeGX9zV5/tnB9Pwzd94CkBGi
 FnMdX+d8cNDGRWfFlKTFxFXmNEF4TJjAowu4Xshrcm/dyd/tTZvqzV1L17c1yEdNpYYV
 VJldlpMCOytmt+5ocJVwQNMt7aZnloT6NrWnQejICm7yY+GO6zE1dsSrtij12QsOOMVl Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0m4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 16:18:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GGAvj0000392;
        Sat, 16 Jul 2022 16:18:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc0m682b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 16:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdE8mXWOI6pD3UXdRvxvVnb3N3N8du2N1wUJX+/vfZS6/RVWAJp+woVXfC+vUrGdMAJC+KZ9hllM8WFXG/XmkMNFMHUmFm19/NVDBjYgMPdqW/Bzw55eAjo5jVpT7J4yuwyjn9uyB87DxJFnDaLsNG4n4Tzf+Mnx7h9JDDY5JIWuAX6D8PJTSgoUa94ykSmgRK1ntLFYG2KccHuQnbaXm7AEve5fvbq9cAA8D2h5DAl7+YjHwNG5f+4nGcIk7oYvJQc5PWVMv9SA6YRIv3J8DqU40oGBTg/3QQX13eMH3jt2O7V/5w+mowffR3uPhY77g/bjZMq8ZJCqolB1wMgNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTLNLW4MwTl1W7MPa3uC8xU2LcckgV9CoCb1u3LIKXo=;
 b=d51NRXQnpdHp15IUZhb0RJhxRfbJAIgSJe+7Gcm0BFdzKQcXJqJHLvf1ty46YL6XIhWXkGxktb7EzRCF7vIvLzxjvwe5rOQINL1zSj8ofJcd+5Asnd9jaxArX50NU+8DS61m4/n1ub6SYtjoIHHkfT4qKGRA2AQWU30d/AwRVBCeeJ23T7qH+3x7k6V88sVbUsxxcDHTnKDBHWeRwV67Q//r/YC7Hi6PrqqYm+uC+yo70nDu8slTkt2z4W8NEKaHY3XaoYwc1WxIBQaURQs2iF9Nu07iNBHuAswRj2G1zSh6/vK8Wi0RvZAftdsgTuBly/af0Gp6S2tqCdsEEuODtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTLNLW4MwTl1W7MPa3uC8xU2LcckgV9CoCb1u3LIKXo=;
 b=FwCDhxhWVGLczP6tJR+72Mbutsu++nMcldxahL8ILvEpmc7aSPpCkHonMpiSFtdVwreQB0YoYevgMSd8WjaId/az8S821tIg9io4b4Mq0q6Se0LQJ8p5RtxLHk/sqwLTmlbxTMY02LD6pSyRqQBGTgmV5U5/NOKJlhNQIFboYyI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1418.namprd10.prod.outlook.com (2603:10b6:3:e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Sat, 16 Jul 2022 16:18:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 16:18:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/lock: Don't allocate file_lock in flock_make_lock().
Thread-Topic: [PATCH] fs/lock: Don't allocate file_lock in flock_make_lock().
Thread-Index: AQHYmLf9MarlRKjvQk+q34ii7gf5NK2BLfyA
Date:   Sat, 16 Jul 2022 16:18:41 +0000
Message-ID: <82C02F62-8EBA-4860-89BA-19ED9F51281E@oracle.com>
References: <20220716013140.61445-1-kuniyu@amazon.com>
In-Reply-To: <20220716013140.61445-1-kuniyu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 880a4ffe-ed29-41d7-1c1f-08da6746d967
x-ms-traffictypediagnostic: DM5PR10MB1418:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uwJxR8lkPcMzZz2yO9k/FZgQlsavCTSyzaEvz8YgcMhOuDu927p21f030/np6AT/n9bQDMAc9CAc2qiRDpV5CjDqheZr6xr7xZASoRpgMTbAjEWxLJplQkvcaPioWXbZSEos3eWcBg/SxWuIUDP1yNpMLowwRhbKmlQEwQtM+BqJjVraW+2+4/0Fe7qyfo/U048kFOyth2ZeY3fqtyosS/yQekXK0/KYLbI7fdR0Go7TKI18v4WHCBuwkr+BoUEjiEePKTGZL5eu7+hap5FRNNhKat9ijV0rp69s0WGkNk1xzZOdwfPYdyNZu8Zczx9bGEbx0tvP0nTAe2/VVQAV3e5jOaFhDhZMKjpYdaWJyYqj81ia8cQo0NIcPDibzFy3JKIAnZ4c7cdEDJQxH6NPrkiVE8cJSZsyJ0E80IN/2fghUw+stsalDXavm1LtXmox9kW6lFeGJsiBOMtEivxcDAMAlH9JmPbdTR4PbqENAT68DqQDmkibwI6NKRrYCGvjHWqlvUuPf+zqpgjdAKgkBfRIIA7QtwYc76Dl2AGwscZmOxyQ0s9oaMTHdTK4Zf47LllXjjylDzFWe1WCz+Wpx35zJLf2CCnKSje77wq8WxhH2jSe5d8EBBPH9sx1lHXTpqkwU2JzEqdfhshRGx3LDFXoIH0joBDZWZ9JS9Ms1/GrTTbOdqYDOj+XM/l9tqRRByXfhNjLzHZRtTf3SgfTVtJCsuzmCGd2fsCc3oouL+7WqZA85O3lHKTvrbqu0rI9oNWxpRWdD5a0iB7RQyYOP93JX91r24QL95H72gSmiz5QJw4WMatoUICarBDkPc6TB8sNrhBde0KN5ZyFITxCauaUbtOFCGt7QTjPdkAy+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(66446008)(64756008)(66476007)(4326008)(478600001)(186003)(8676002)(91956017)(83380400001)(36756003)(66946007)(2616005)(41300700001)(6512007)(6506007)(8936002)(53546011)(26005)(6486002)(316002)(33656002)(5660300002)(38070700005)(6916009)(122000001)(71200400001)(2906002)(54906003)(38100700002)(76116006)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ja7K5kPXwETddvBDnKvKUnZSm7hIClMZtbyQUXiiInIXRgoU3FXJXGJx/ZQB?=
 =?us-ascii?Q?0toVug9fimv1fVn8aVIJGLfgfmuMN8Ns1kTtB2DAQUB95UgzgYu73bzNJyoT?=
 =?us-ascii?Q?JtjITZjH0vv1HBJ7T/1GBH2+7UMjG6GvZxGCVMDHHUy6LzhUIgwGw1J368jg?=
 =?us-ascii?Q?KlilJpy0J82hhxcoSxTQkQsdLHrUv8cCdDxLhozs8hKtF4gV6fKTc9YQcL3G?=
 =?us-ascii?Q?Wgg/LqTTSHews1wINf5oWaWzRETGG2DWXeDiyumpksVcNWxd/xu6bhmgrEQn?=
 =?us-ascii?Q?Hv1YM2tpJr4XNMOaQIIFuWfD+h3pMG3XHWl/KSoO9OhEx9VYcwJB4SUt18JP?=
 =?us-ascii?Q?mFFBOTfloOPGGHN4/IMrwzJiyrtpZfz1NjzIULNYIXs3H5wDqukKUY+uvpRY?=
 =?us-ascii?Q?sOmkWlGB4Vedw+2vR6y3HZf6vLzsF6HwXpk47HV63AUJiiYfWz0MaS2cQjHk?=
 =?us-ascii?Q?FTw4cEx5MONXIZDITWj0DJfYRWt5qDUxIfrAdi8vMdCltdP/UfN26Sdzg0Cz?=
 =?us-ascii?Q?jY2Grvj61p2p4vjSlTQPv/80LdSZZzGWQ2Pwwwm1OlAD0O05GxNQF7yGsNNx?=
 =?us-ascii?Q?NxkcNkOY52gUxym9WUoFO9f6UdRPpo0WoN2dZ9z4tLhajPsyv1evlnMpl4C9?=
 =?us-ascii?Q?XVVQfoRvGXaiB9nQU1u2yp4w8WxQxqszbASRGY1KIO9xfTuxZcqywWzUFlvn?=
 =?us-ascii?Q?B3jP/nN+9G3yC7B7Ao5nqVkRp9vr4rKdh90TNk6iRSdqyZzv9jo0IjgxSk0P?=
 =?us-ascii?Q?GdOf2DGWmfHVNFc37uclSNzULsO/Hcrw+i2OiJ+r+iVNPPgeUJFCc0kaBX9o?=
 =?us-ascii?Q?gG4MNGUXgMcDNyknuNvP47bklXEn1hfIXic9V/B0X240AluEW3459wc3q4iO?=
 =?us-ascii?Q?iPfuaCtWAyTHUZq04qZPyWn56tkb6xMO7pwt6utIxxSzO28SoRAjpr9an79c?=
 =?us-ascii?Q?UcUwb3gZaAo4LGsx39fbst0zPXyp8mMI4KH52uLGUQPrMM082PjCF04YzF7l?=
 =?us-ascii?Q?2U+wYbUcLKcsax+QVK8ZtiofuqNXpOXCwjwdBoS1Gsni77z6tdCEZY7eE2w1?=
 =?us-ascii?Q?8QrIdXw0rlKZFWS6yaSsZimI6/R9p2DjnYK5BcTPGxie70KE5jhsCTkM8Djq?=
 =?us-ascii?Q?ArTfr8mFue9kcqg9/1GeO5o/V337egOtCjwu7Q4xmb+tpGWumxzavmzsq+Xt?=
 =?us-ascii?Q?fv/j9q/fQwdfBsbTyRGgpQl4X/waQ58WvjKvH1DwcwjTy39qaQONYUnfndRA?=
 =?us-ascii?Q?Fj09nN6fGLQ2w9nV1fEx3cLKP3WkVI90tOvBvlnu+H5kE11A95d5qHCrM9CQ?=
 =?us-ascii?Q?xnOxoCGNrtz7Jbb7vdB7SDnalkub2IoGqZekPK0rcPKk+FPPEmO8xvYuDOoc?=
 =?us-ascii?Q?H0rt2G9k27j8YkRrXDlHF+QcqjfZJbN/G0gHZ2N6Q/H6UcKUqriqWlqi30fe?=
 =?us-ascii?Q?AXXk0wCRzmBWXsS6bt+LZnTkvnffFd3zVxd0JO6T8iaNyEFTKudYZvjb3725?=
 =?us-ascii?Q?l733cU41Re3ge2YswO7yZ+EDH4FycrOcBC8Eco9hjwIANQIzdtZjxj/E0cRD?=
 =?us-ascii?Q?Kjvgu1791iiR++yIBH4BwE5L1/VUAzkjplTxttWimaGdOsXMUCE2/Q7wF+6V?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B09A70A90BCF9247BD3E4A66BFDEA67C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880a4ffe-ed29-41d7-1c1f-08da6746d967
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 16:18:41.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOQ8CntPntdxq6MpPxbqnDLCqhWaVMucofpMZAC9onPNxpf3Jd9W7VHx97ZLBELdPidNvAargwcYdrKkcfWHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-16_11,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207160070
X-Proofpoint-GUID: VCRakZVYuUWW988QdmxJ8QkooGDKXoSO
X-Proofpoint-ORIG-GUID: VCRakZVYuUWW988QdmxJ8QkooGDKXoSO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 15, 2022, at 9:31 PM, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>=20
> Two functions, flock syscall and locks_remove_flock(), call
> flock_make_lock().  It allocates struct file_lock from slab
> cache if its argument fl is NULL.
>=20
> When we call flock syscall, we pass NULL to allocate memory
> for struct file_lock.  However, we always free it at the end
> by locks_free_lock().  We need not allocate it and instead
> should use a local variable as locks_remove_flock() does.
>=20
> Also, the validation for flock_translate_cmd() is not necessary
> for locks_remove_flock().  So we move the part to flock syscall
> and make flock_make_lock() return nothing.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

It looks like a reasonable clean-up. Handful of comments below.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/locks.c | 57 +++++++++++++++++++-----------------------------------
> 1 file changed, 20 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index ca28e0e50e56..db75f4537abc 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -425,21 +425,9 @@ static inline int flock_translate_cmd(int cmd) {
> }
>=20
> /* Fill in a file_lock structure with an appropriate FLOCK lock. */
> -static struct file_lock *
> -flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *f=
l)
> +static void flock_make_lock(struct file *filp, struct file_lock *fl, int=
 type)
> {
> -	int type =3D flock_translate_cmd(cmd);
> -
> -	if (type < 0)
> -		return ERR_PTR(type);
> -
> -	if (fl =3D=3D NULL) {
> -		fl =3D locks_alloc_lock();
> -		if (fl =3D=3D NULL)
> -			return ERR_PTR(-ENOMEM);
> -	} else {
> -		locks_init_lock(fl);
> -	}
> +	locks_init_lock(fl);
>=20
> 	fl->fl_file =3D filp;
> 	fl->fl_owner =3D filp;
> @@ -447,8 +435,6 @@ flock_make_lock(struct file *filp, unsigned int cmd, =
struct file_lock *fl)
> 	fl->fl_flags =3D FL_FLOCK;
> 	fl->fl_type =3D type;
> 	fl->fl_end =3D OFFSET_MAX;
> -
> -	return fl;
> }
>=20
> static int assign_type(struct file_lock *fl, long type)
> @@ -2097,14 +2083,18 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
>  */
> SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
> {
> -	struct fd f =3D fdget(fd);
> -	struct file_lock *lock;
> -	int can_sleep, unlock;
> +	int can_sleep, unlock, type;
> +	struct file_lock fl;
> +	struct fd f;
> 	int error;

"struct file_lock" on my system is 216 bytes. That's a lot to
allocate on the stack, but there isn't much else there in
addition to "struct file_lock", so OK.


> -	error =3D -EBADF;
> +	type =3D flock_translate_cmd(cmd);
> +	if (type < 0)
> +		return type;
> +
> +	f =3D fdget(fd);
> 	if (!f.file)
> -		goto out;
> +		return -EBADF;
>=20
> 	can_sleep =3D !(cmd & LOCK_NB);
> 	cmd &=3D ~LOCK_NB;
> @@ -2127,32 +2117,25 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned=
 int, cmd)
> 		goto out_putf;
> 	}
>=20
> -	lock =3D flock_make_lock(f.file, cmd, NULL);
> -	if (IS_ERR(lock)) {
> -		error =3D PTR_ERR(lock);
> -		goto out_putf;
> -	}
> +	flock_make_lock(f.file, &fl, type);
>=20
> 	if (can_sleep)
> -		lock->fl_flags |=3D FL_SLEEP;
> +		fl.fl_flags |=3D FL_SLEEP;
>=20
> -	error =3D security_file_lock(f.file, lock->fl_type);
> +	error =3D security_file_lock(f.file, fl.fl_type);
> 	if (error)
> -		goto out_free;
> +		goto out_putf;
>=20
> 	if (f.file->f_op->flock)
> 		error =3D f.file->f_op->flock(f.file,
> -					  (can_sleep) ? F_SETLKW : F_SETLK,
> -					  lock);
> +					    can_sleep ? F_SETLKW : F_SETLK,
> +					    &fl);
> 	else
> -		error =3D locks_lock_file_wait(f.file, lock);
> -
> - out_free:
> -	locks_free_lock(lock);
> +		error =3D locks_lock_file_wait(f.file, &fl);
>=20
>  out_putf:
> 	fdput(f);
> - out:
> +
> 	return error;
> }
>=20
> @@ -2614,7 +2597,7 @@ locks_remove_flock(struct file *filp, struct file_l=
ock_context *flctx)
> 	if (list_empty(&flctx->flc_flock))
> 		return;
>=20
> -	flock_make_lock(filp, LOCK_UN, &fl);
> +	flock_make_lock(filp, &fl, flock_translate_cmd(LOCK_UN));

We hope the compiler recognizes that passing a constant value through
a switch statement means the flock_translate_cmd() call here is
reduced to a constant F_UNLCK. It might be slightly easier to read
if you explicitly pass F_UNLCK here? Dunno.


> 	fl.fl_flags |=3D FL_CLOSE;
>=20
> 	if (filp->f_op->flock)
> --=20
> 2.30.2
>=20

--
Chuck Lever



