Return-Path: <linux-fsdevel+bounces-32415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E49A4DE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A011B2689A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB29179A3;
	Sat, 19 Oct 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7ZMbQzL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zOEMqfik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2419746E;
	Sat, 19 Oct 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342315; cv=fail; b=QwgYt6NHtQYDeFb86MzwcXeu+fcWdSnxkulgouIUGrd8Ucb31J+DQ9JYj2xW587IlXTWI+Z0flZ7wWpHVDdsTnSjx3PGclSvNV3MMGcxOSJGJW8p4v2YRR1rst1rf6Q90QyWuK0cStCPA11zC+8MLRkBi6OiZe0AMptYGqkkv/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342315; c=relaxed/simple;
	bh=NUEk1bbDc8usjD6kSJzNyzPJWJ5mEOZbk47XAZjJD9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aq8huiWeRKk6ITnMN3dvG3Lw6S7qiWVcC+GFJ+qdd7z0VAATIkg7GvR+pQ5tZI3jg/jUx7SZQYsnG/zPtaNO8KklgCpkhbyKppzjR8wkQsGydiSDQLu9GBmG3SmQPvQnmkLqRmaOAl+gtsuno0ZU8nJIDcmMwLxLcL9/l2FlRQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z7ZMbQzL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zOEMqfik; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JCMujB010965;
	Sat, 19 Oct 2024 12:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wx3cU0sDj9oufseYMbZ3PwTSRTprtFQLR9CAme1UvfM=; b=
	Z7ZMbQzLCD2oPfjj+J96PpoRvtxk8hS64hmbLsszHYKeuPsHnNMSGrisWP0a51qr
	NqdVrewzCRf7EUDVlcPeretHWYYdxm8703K60wbcErp7MhDypmyXUDaFkmC1WSdp
	eeNi/TYJRrepxAXukYSHX9cQ+Dp3BMU3k9Z5G1uc+k0vFvwo9OTdADNUwXkowmu7
	ZvGQ6PHBYedoGq8Mm1p59yapvq2bb2Ep6KogzS1x0DOX5ndDIliNlL0cOesnO4Ic
	1R3XFg9dEMgx2flxifQCmW30vFtjmkuk7WTHvib5aU4LR5A7NI+huLwNiTDM8VGU
	VFHqsDBjyk1i1md/zK1U3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54589tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JBO4PU019660;
	Sat, 19 Oct 2024 12:51:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37atge4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrVCmPazDaURfnH6AkgMHCwfFAbHQ1q37kRYkz7x6oS/9XUoIhBCP73brGakrJVfqocaVlg3+mPErwNgyIZzMakZChAqUn52QUMWsFGOAnjzXyjDi2dfhy0gKx6JbEAMy8bwh4UuDWy0IMOyeaE43PLlFxWzyxS7tYNUUOEgaD+4PXJQDMkJOHCn1+fdxbSvLo4zQigASQJkdRdwfnBeko0KV1Ci1tmKshmKDHIZLPgfQ7ELNmHAJTr+/mTfDZasX+9vNCaigzM9SIGmqbvYZ0vhp4cUGmsxgFAGORKvMz0p5XPnl/7RNUrJ8kw6SC4t4djf1myiaXxfIAv5HvpXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx3cU0sDj9oufseYMbZ3PwTSRTprtFQLR9CAme1UvfM=;
 b=rzbLQff8uFjhzTCnvmiqKvblYe04FLBQAW6gcf7Q2BNahLsgDZrWGe6Lp0IUreqZJtwJtm+8xzedLMpNxZNFmybEDeDi6x4Bk6iwiBA7HFPuvlID2dqyGxnNpdHI6afQFmZA5nIfAS3fxnRWtmLOXUs28Nto8Jp1OPrckXvBx/l91PzkPMH5Fa7EWIRGD4ssMNp1dwbHccSAXfj6o8CjjX116Mx7Js82vfg4lOf6cucW0jINk4uUSXv9Jm8sXEEObcaok5e6jttjkvi11hGS1lJgOLlEkYEQjimC862XJ9hO37Tm6oGTo3bdXoilD9PiJSg4KjWnkvbuKKZEyX3SDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx3cU0sDj9oufseYMbZ3PwTSRTprtFQLR9CAme1UvfM=;
 b=zOEMqfikhrASQ7fyMflStcBIpBmDweeLI2/JxJjNI7sYhON2MVSNo4ornoIUp+AEvgiZVz+gE9ibitwThd8mbYoKZAD75VvIsSuJYDU4blGKszsqlKSE8g+cZV8rTwZ+19XwExoG0s/vBjtbslYUQtEnQUPS28gsRdEm/FF61eg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 7/8] xfs: Validate atomic writes
Date: Sat, 19 Oct 2024 12:51:12 +0000
Message-Id: <20241019125113.369994-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0030.prod.exchangelabs.com
 (2603:10b6:207:18::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 823767fb-f123-47de-7587-08dcf03cc202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKxigOy90dsc9XvSj1mV0Xik6dAQTMCfD0Iqrt+kWxKJ+sIVe8ld3N0yro0k?=
 =?us-ascii?Q?TDLVqmpHoRcpUrao1NEIog6AK3eGIRXi6Sg8jVNVbVnRIcCVpx82gLDuybC2?=
 =?us-ascii?Q?Y0GJS0vNy0+VZANL9sYKnLzfViRvZjrao8wYZCCxKC4GKCB3Boglxi8SLVhZ?=
 =?us-ascii?Q?aVLgiV0DjeRfxdo+S/qIWO/v7zDJaG13RUpNL2GW6mA/YH2cAjQVg+Kvqvp2?=
 =?us-ascii?Q?/9hsylHsHW8Kke3ds/HQXqeb90ixuOCKeIdSKKtGGilC1Z4B//HdNV3yQuc7?=
 =?us-ascii?Q?LXP52xft56fhdUk6gNrgkf9mexfgjhq8US1YGxXAUrvXsSgE5z7q2vUMS48K?=
 =?us-ascii?Q?niB+y2n/U8AmJoXZ5KzDE70K/d/tz3LxOs4pPy6BV/ff6e3OvIj5Xqzd+xMq?=
 =?us-ascii?Q?4Rb2RCIVL9BW2JpXTSsjqmGZsEaUIKN5zRyxMWV+bTeS/ENeGXWo0ly77o85?=
 =?us-ascii?Q?PPLY3+3BvkSKpOMtSlCGTL3qZE3g3tCrgtwPETkyBO4kqN14sFZA1m9MZ91G?=
 =?us-ascii?Q?zyKUuaRBQdo/2RQvLMAKFHnsDa4TjJkLCByv6Cx8jvmBZPd6D44eRjStXgQe?=
 =?us-ascii?Q?0tMNHLdbh0b+aPwGEIO0Ep5lGey+bhwf1i8MDanDu+0vRM6fFwpLu+W9VXhY?=
 =?us-ascii?Q?/9VWFNX4qz/J+kHLOZroSNRiYEpPmJzVSXaDtNqM1ufZOLhW4BD5WBnk1rZg?=
 =?us-ascii?Q?EgcVcPlJ0118EcpjB0fjZw251xWbnPLPrcWLKV9/eS9qEARFn8h5nJMMgzge?=
 =?us-ascii?Q?zxCXzDDtcetSKMYrtm7cMqTGpYNqmbkZwOhKM0U0ZEk/6pU1fg3jYLNqZF+B?=
 =?us-ascii?Q?mZKVny7Tm1PH5UZq1O0VjU6d1yjeZPUQp5/lt7rLNQkz91pJzDJguFf/voaJ?=
 =?us-ascii?Q?xQnAXp8RM6JZmDeUy1Uu2kwDtLGntVYWaimvE+b2Wwol4HMRPNkE8hIB098u?=
 =?us-ascii?Q?TYQTdgg/e/YZCrQmq6Bv6cwomTkgpzWoHAHKwM81012WkkDnw0Wks93/gbo5?=
 =?us-ascii?Q?7/SXZAqNQUu9Q8CKk0OIqtKmNjLIAr4IRKw3mlJUCqUMYdWA7opUF5E9e8Mr?=
 =?us-ascii?Q?ySJN7Crdxgby4p1afnHNWcGAzl9XZT1G+1P4yYCXgtvtcusewUEuKKO+HwvQ?=
 =?us-ascii?Q?xysLSCvPiHoEVBa2qdI1cSikc9V7kh8lS0RP8ADXp7RRlEKnDaMM1c6Q2hJm?=
 =?us-ascii?Q?du/WKr5PNxcdAfZXFBr2jNmmoYUXmbdgxyu1Hq6U9F7FFYi/nmBJlbW1ftVM?=
 =?us-ascii?Q?+HUpnjqhiJPF+vlhQ7hMUPl9RcXHMzy6j0J6z1GiL/joXKr9YmYMUIB1sKMc?=
 =?us-ascii?Q?CBS7VRfJKG0mlO50VbERtpzq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?159GqL0zg/LTSKfVF11K3Lt63lVBfH+eD0btCZIsf2PX26tJ2JOpd+iqjUGK?=
 =?us-ascii?Q?XxZoExkcKDeOZmsiZhlMvy72kP5Co1SaMPIzvKsbsZzEXKqrujXPv/3bAw5V?=
 =?us-ascii?Q?6sMInpDG4KmdwT0o8J+bBQfOriZjqmVVGrrkzFyjNlSFEO08YCSgp/+xYWTP?=
 =?us-ascii?Q?NV7gDt/RJJyE06pQxj0SlQgf0Skml9sUOcvQ8n+7GY+BB/ebKeU25rnA2CVm?=
 =?us-ascii?Q?lmIaAQ7Jni6BWt97bUMPDRYMaMTG+FPZPZKZf9PLVdDbYKiK3vNw8aPvXZjg?=
 =?us-ascii?Q?TCzR0F3ZT2nxFnLkiv75e7cdTcScm124iswpFyWJ1e/3JyK4AKlFzB33UqBk?=
 =?us-ascii?Q?+YZFLMTVpFZwnvwJb/D6uRpmEUMNPbwIb3PXOJJwEOUPgN3tuaAS3KLxpQmH?=
 =?us-ascii?Q?Jm7st+mBWTHjYb7OBv+Y03e0945+Q5Bmg4PkjHV6BccRgM8D7sheBo8+xL14?=
 =?us-ascii?Q?snDTEl2WfQfXqULSzpNN9fZcRRGPkMQdmJ0bzqxcFXOehb2PBsRyX7zie/zO?=
 =?us-ascii?Q?KVwxoGsnrIx2SsEcZSSmeynAU8d9zzRf/aQdGMiaMLkc3MfWMAqJmOchFUhV?=
 =?us-ascii?Q?QuT9Azg5hN4362ZiE9f6CFsXEEmp5qc0zE6QzFq3bFznfsCpEeOnxz1zESMJ?=
 =?us-ascii?Q?j/BZn/UAvblpsdjGaMjNh7N0dmmZrYfCWqI7lFp2JbTvOzSke2GQjtvyLmDo?=
 =?us-ascii?Q?2RoeOtql59dQ8nkYvEyRyCuZn+HVHoiOAyia0fb3AkKQuy/4CSxczBz5CxOl?=
 =?us-ascii?Q?eolf0CGbdZsJ1b0o5lh0X+dYj3CLU6ntwjPc54R9pfsUYR5JhK26Bb+g0Lyx?=
 =?us-ascii?Q?MJx55OtS61ms/xkVjV3u7DWrBT8B/vB4o+4MV087o8LoLjEgZXH83sxKMk68?=
 =?us-ascii?Q?bWiuwKAsFjDfiErQiX5odimFyh/TWbMi7Tdi5u6e9o31pXvTjySOkyTSq2Ik?=
 =?us-ascii?Q?4vyQHcNtNTS7U9DEBEgLIjjhE9bJ3KOHHZWISa38DP1k6rm0YY62AVs1Xz41?=
 =?us-ascii?Q?XDXP5fJY23dI1FmEZqQeTkh2Ph0Pq02GlYa/ryuv8AMRcKkwjttLzD5j1gqM?=
 =?us-ascii?Q?DUYPG10EFU0vokws89ih4vRdiQDgUljTM9I5PoaVR5sEjyYMZd8uEvMBE077?=
 =?us-ascii?Q?0fo7sqB6itscOUFpX09lvCue6xpTdgtwDXcvxp9sI9d/3S6T2Zzgw40AMVP8?=
 =?us-ascii?Q?nG4DEQswnqYG0IyjN7scGxDdynB8EZ4bUWyN3UJ0AjGs9LlADbHELs15cL+Y?=
 =?us-ascii?Q?fT4k5f4fr6jz2CUgQAA740hqho9xNVT/L5D2RFd0ljHwPBXNKzUTQbPGFLo9?=
 =?us-ascii?Q?CzqzM98SrhxigaFo86BZdzAELHL3I+2NJJ92e3knvGF8t/0nPssagsRlt+1K?=
 =?us-ascii?Q?i7N/A5s+f0sCKb3BOhWBx/zbQteK5KtN2CLz1uhidtIAilC66yszKQHV/cJP?=
 =?us-ascii?Q?jyjiI1pvZhpVa3/whGYmnaMud2P/ZAqh/h3g5Dm1IUE5wfMJuU44+kYLl4h/?=
 =?us-ascii?Q?B95dqBD1XDvrAGVkKLkW5elXaymAhvMTNVB6v97knlqsb0p/wrazFv+Yg6XR?=
 =?us-ascii?Q?+KK+HjPmC9Ho/ypl9yIRcXkUjQy4v3ogefsuGyBL81XtZ7VDWUV8YKUM58a6?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AIxNlKjfiYuNryB77kL/Ss9yddP3gM65I9i3lONz3sNayp0zW2WSakZroclqq+vDTFfVfd+gdE/RhazB9YZJDZzen/SsdhDLy6yNta6TSKqO54KcshYE+C4vtGiPms3bNBOU7ubHib6nGZETWAs2TYVLKw5K6lvyHGvpTnX/2Pla8tRZHzKGw2uhpZ54Hb1ifgTwlnGIRUPF2B79XoY41jYhoJq2O1Cw9Tu3vU7WR4jg5JEa+fcwfmkr5wVy11Ubcn9gb3u9p8MvKQJvjRjlsgoV6sOiQ/rBs6g3OUWL4v0dLvqhFydrTzq6S3vcQ47WRmaTWeICrjpN/OpxYrQSqKMFWvRHHq6/BIR7QOE44hE7B4HKgwgirwpyvNVSAIaakuFLg/DEVguICaQbAqSyjhYkttS6FOQ21t1PwolS//J0LKLO92/DvnxvR5q3mZY1WRfcSH4tN+OIy/J+mafmj3b6ZFFxLGK7pNf9NYZ1phJirEf3cpn7Ub4VdPQh7MKvycz4WJVMgHvlOiMJVgCYam/8VyMyk86VlZsU/5sNfb8BroW/z+V6vr1ZfW7zOiOp3zSr3tjmttT/Zo4RmfGCHG2ew28dxmiI9qsYXalGWm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823767fb-f123-47de-7587-08dcf03cc202
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:32.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDfloqVSlH40E12vKhQ0QpYypeHcRSY6/J/3dknEVYT+BKotvsGF/zBSllneSp61mALCKRqxFnIXqdO6laF0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410190094
X-Proofpoint-GUID: HX-dL4Bm8ey0AAENGJumuEMAfFTy0Hcs
X-Proofpoint-ORIG-GUID: HX-dL4Bm8ey0AAENGJumuEMAfFTy0Hcs

Validate that an atomic write adheres to length/offset rules. Currently
we can only write a single FS block.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_write_iter(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
ATOMICWRITES flags would also need to be set for the inode.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b19916b11fd5..1ccbc1eb75c9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -852,6 +852,20 @@ xfs_file_write_iter(
 	if (IS_DAX(inode))
 		return xfs_file_dax_write(iocb, from);
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		/*
+		 * Currently only atomic writing of a single FS block is
+		 * supported. It would be possible to atomic write smaller than
+		 * a FS block, but there is no requirement to support this.
+		 * Note that iomap also does not support this yet.
+		 */
+		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+			return -EINVAL;
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
 		 * Allow a directio write to fall back to a buffered
-- 
2.31.1


