Return-Path: <linux-fsdevel+bounces-40739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35298A270D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B163A163DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FC20DD68;
	Tue,  4 Feb 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n9en7u2U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aneSgrbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A26211A38;
	Tue,  4 Feb 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670542; cv=fail; b=uURvCMcT3736oTEyoTk3fY+RvC5DfknIRxp+gxO7+9IfCX4mOHParl2MG/7AOyHfkMlzdzM36rKrqh4ZCPSQ8QtEyh8vtbso1ltnw9LfnrPlF+9LuS1LPxCdg8PAuton8rm7RFsl1GM623A8FJ3yMedilifnH6HwpsmTO1iZkDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670542; c=relaxed/simple;
	bh=0GRzJsSANWNKunZDZZWuDfg22sxH4GbO+tm/ow9KDg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdZayowiTdpfmJcc8EY1r1Dxvbttw/ldOP8YpNSnbXaf+5PSJhj5Lci9j6j+kUDjtC0U3xQmPd5L3peVARYehpynI8C1rqt9Rtkf974rSYRkXhTZzrdtsPwjNRkLWkIVDyaczWpR9mr4iPujthG4NIpiE4XgqVszwzLvb3Q1juk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n9en7u2U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aneSgrbQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BexCi006306;
	Tue, 4 Feb 2025 12:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RRBEZgjOeDaG4fnGrj8fTp1TPFhBGnJIfie9VEcdpbs=; b=
	n9en7u2UFLa4t0Kc5LOOJnswsR2GIEfP9o/ViPs2Ds0/pIpD60UhYyOAw4BwRetH
	mAmoHnVTA9y14WS5PeN1jP8dzPwUVM9zhFMrEAG5nq/TzeHPyqCP/8HKSBuqnok4
	vGU2v/+0Hm2/fK749wBndHdnlH06hyW4Y2wOXMpkRvrzy/pBHmXnTQKvfz8XQSXp
	5gCDTIVX72E4Pv70ZfOMqUb2nv3NYMN4xXd8BTX0u7Cg4YHZhziH2IP5cMCUVFIo
	4HvnK7BsCByYfpf3RgRIhwBtXD/FCGW/lymOcov+I/q/RKg0jzafBchRQmF7UeBW
	FtZi+yqeQJsF3QvP7ETqNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy84k9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514AcOQv029134;
	Tue, 4 Feb 2025 12:01:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p2w4kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FShoh/GT8H2gqAQhfpCI56vSrpaEVwyVc+s3onObGWKZvk8LkdN3ozN2NkCJVgVphwhZw5MFC9BCycws+QiJX7/yCJ0FCEi7Ufw7RwbK2Ka6QbkUdwm7T+Fhn52SMSyNRQ7xBR6E64X+38etp+t3jvTT3zUNYFJXW/0JblOuikaemhpxPp57tw6miN7hoIJUw9GVMsFFhZIoRIPPPbwKR0DHawwXZP6aajfwBPPcVXsZc8b9YbSokc+Xum2VB2WeEJGo2/lYeD7k/kujSAb3J4NpX3jgng3MDIgnOnjv8nFRJ3TmNrza/4qsZ0/oBreaF7lQC7UgLiKn/QJB1Tb+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRBEZgjOeDaG4fnGrj8fTp1TPFhBGnJIfie9VEcdpbs=;
 b=CJMwdSVQJYaI1KlbDQ6YVvgTZq9IXOw162m9PRjfUnoQkN567TI0BtUpExiyJgphAsCeY0QuG2aZxhOqsw7vLOFSf+Oq3PeNb7ae33STEZHsrlSmnA1jYdzAHcsjcTCbMc2JaMX8Vgsz669QQeA0rkbwYL8CXiiPTHbRCEE9Hd58UHvXxxGgJEDQ0Tj2zGWj2uj0poQb6UYneSneM/LBUMHRtvWnIKM8JlilVmHiYIqxkXRCcX+uQud4ByUKtNwQhymjWbopMpbumk/KW4l8k/ccZxKT/kWNsHXGjtliaodYL5HBrtUQf86h+DUisRDSi4xvUrpdY/ZPdiyDc6UU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRBEZgjOeDaG4fnGrj8fTp1TPFhBGnJIfie9VEcdpbs=;
 b=aneSgrbQUBfLFWugdkGnNQvVwe5jZOkxp8nwjjq0oQgostq4BKTBbR/Ghd5NLvQmWi4sS/CEHyQh1P6x9bBe3H22Jm71GcxFlX6ePfHURVZVGaYI878cDyx2g8BDpX+pYK4zt61zJbnJ1qDfF6HSi0jH8KB7nUbLEvdRTtKZaGE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 08/10] xfs: Commit CoW-based atomic writes atomically
Date: Tue,  4 Feb 2025 12:01:25 +0000
Message-Id: <20250204120127.2396727-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b88e4d-4c66-4b40-5687-08dd4513b6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWVYafoC6kDdP9IzCIy65qr9imFTp6VCkMN+Vh4AvOnSJRW4iLeikWWMz1Fy?=
 =?us-ascii?Q?Vn3Qae3xZBHwMMw2Hb/1rHbO/uUIvmyMUAovG0n+EEG34DBasIaRYtUK+UMl?=
 =?us-ascii?Q?lcUyvnOMkbx379Dt5EN2vUMEBvMLuDr4i/wOW6+K7IZXHi/U0Tg3w6X4wB7Q?=
 =?us-ascii?Q?gBbveWyVdt7is8aBJIwtSjGTLtsx5mmeF0XSDs5W+fHe0rKqzsWPwuih615W?=
 =?us-ascii?Q?LoRhtYzFw3TUe4aHOqa/f7QdaIU0MZVxzkUnNQB904lIB31hOVXHgjy1oEzA?=
 =?us-ascii?Q?YvA0/aT8iC+IYYyCvW1YlxPuMYIeGuhf9GBx9dDS9hKVk7/ghlOaOJwL9CHR?=
 =?us-ascii?Q?X0D2jAJ6B5mOvvjPJN75sEJtQoy+b9Du2JL+6CObf9SgAdmA5a23J0WX+8oT?=
 =?us-ascii?Q?dTA8KA8w7f0FhAOm/tO9pYqkTt9KOw7hZFbSqNHXyqB0Fnu8Yx1IqGj9zRfm?=
 =?us-ascii?Q?dxNQ5v0u36Se5dVx5h+RrEuIr02C/xQG5P70Rv4U53YoVals1PHIaJvDym52?=
 =?us-ascii?Q?YUXi5vSSlxNjkX6ID9WI84UeB5eloFonHJKFxhojKqFlxyjnBGGH4YxafNRd?=
 =?us-ascii?Q?HrAhv8UTM5FfgUVfaWeUAOle5iFMOdDaNIBXFd977SZ3hAeUS4AV+6sz3gq+?=
 =?us-ascii?Q?P7kjVPSzIjD/UfP6f+lbQ/8GMiAi5ctdOn2UC780k4W++TUK55BjSAMkAAxy?=
 =?us-ascii?Q?2Sa9mUa1Aixw5cDAGwC0UCt6Tk9fxyMAJ2xByBpPg3eWZoyiABE4Sc6IYIRs?=
 =?us-ascii?Q?zQUCqzAhVwCVSKIv/tszM87DRyRsOr+C010qxnkJAm/lLsNA/6GFZZ9c7NSH?=
 =?us-ascii?Q?JVub5wLcez+Y+ciU5U4elqPzX13TDHGIPVh96AyFQ9VUt78e4EAh4ZOBik/Q?=
 =?us-ascii?Q?ePiD3tZsC78HurxE8q0ftQtkUTjOiaxzuGxg04W05fKIlPP1D20EB0uyqxJI?=
 =?us-ascii?Q?wAxZhq7YBOhNtYN8xYtNp7Z//uw+lTytaopKLSzJqhuAkKLaSOFo8B+KLuQ0?=
 =?us-ascii?Q?cG3xluG9qP22wyIzhhepc/3pHfn3f7O/0FpkvN2NY3nvm6yQ3EtuwHiiQAsD?=
 =?us-ascii?Q?m1iJJ4KvpBYg9Hr4gTHWFfYhBVKOk4zc+yTRBk2KiNbX6bqSLTt6CPNwWzTK?=
 =?us-ascii?Q?SkjmywjqMxNjhRUyiKiRPVdf1hcmlj4DE5Uat/tS2rj6kCZes1H+JUUTe5Ku?=
 =?us-ascii?Q?ih8RqY93xIMgUGN5opZ8mFHH0gydd+m5mLZD4BM9aTz1wE+UBxuukU0oblme?=
 =?us-ascii?Q?M3rAb/W6tjm3p7iALtKQqVnBrrv72MkTrS7RhmRbvE7nia/228UYtS4auN6K?=
 =?us-ascii?Q?pSDq0y/LXXND6jVQ9DJ9tFgzi9vEKkzhJI65Wi7h7/Bs+8TMTTB/eskh1b9J?=
 =?us-ascii?Q?5S6i6V9uZX2HIkSyff1PQ+HHqai0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqLjC8/D62kBRQXIChPZpZoRSIeqa+lllPW7XoPfei2dbvP1VTf+gJKeq3sg?=
 =?us-ascii?Q?sdtF8rPb5Eom7lv55Dj+0MaBhZS6MzkgVtNTfX8IO0QqeiO/y4baWyQTEAX1?=
 =?us-ascii?Q?LOFQzujd4E5DUKtLPBrxI+0OxLzNGpSJ+N4CvRPq7QTD3FeEnr+hCtQ04MmQ?=
 =?us-ascii?Q?cQXEQ0MwDSWyJMCMxwpb/g1rNDcAc1xRDmKK1QcAyszFIWkb2y5P8F9GF9x0?=
 =?us-ascii?Q?KryBDVqtRzN+QsLSKFoQKu3XTvGq1nLBEtDJgidAMqeMf377/jS3y+2W615E?=
 =?us-ascii?Q?zK12X1MQbBGJ/wxoWDlYJD0bnMK9j1dzkV+QUWly5toSVIOicqfE+t2GKpSx?=
 =?us-ascii?Q?q4P2bI4VSey/e7sMV+rmu364sTQNWWsh1VVwQqEiDvcNbhzGId/0ydjYRF9l?=
 =?us-ascii?Q?PGWdxxq6Z9iIwpOPY2s+DE22Y38QpqewzXTnq2MD58XJRYNDsLKMiUWJzZsQ?=
 =?us-ascii?Q?HX3mfLxbjmitLpB9yinHV4g2XJJE1rbOtBwvXX7G7DNycIP98QNOP/Q6ugh8?=
 =?us-ascii?Q?nhusrpFCegS5XeVDo9tb+Rr/zssCbcf73sRouDP8nwWviid0UFb+QDDGlOnc?=
 =?us-ascii?Q?/416ZGPlUVaq91KkV/rsLaZItFYUK2qAGBEoEAE5d0TBOwqdcgLaFcYU5Q8Q?=
 =?us-ascii?Q?vLunSmYMV3JcVNtvU/L335NVyysC0ZjrpFjmCxJ807wlaKF33IHeHYiY+r8T?=
 =?us-ascii?Q?E1yCdCYLFgLJFSjBYDX400Em2vA0v8DBhELbcJEMZCqZ7a1HJs/GdKp42/3J?=
 =?us-ascii?Q?Mc0nWS0VjkUtHKXcmLl9S5f24xYJQojjoV8dzJeqLrnbwhtnFOYhei0crEFS?=
 =?us-ascii?Q?J3v8eZachYz35yxBcBEkQLTYowcSbGbPQfp4hy8+expBSwDbxnt8SCPKGD++?=
 =?us-ascii?Q?feDaia9ChK9q4l+dHG5W+SKGTRVfwBarNlWaYsIp4uTpCZggmKbNbrjhBw5Z?=
 =?us-ascii?Q?3dMCi01Lalcz9ZUe9+gZJuZ8RB5L8XK9eazuOcdEDH0LBeuqQJl0CHt5sjEP?=
 =?us-ascii?Q?LPrARDWHjYQQbhjrjdGL91EKKVn7Dj/RhmZrc7IOXg7lqqXFKo8hKE/xpPuC?=
 =?us-ascii?Q?EdyrCrXfWMFh81Cg9jrpCYr1WcaeAZpYXTGJzmZtX5CsfMC6QVNZn4hEgYYy?=
 =?us-ascii?Q?gEztk8Gua+eDFQY3mPfEvERnR+a7iYB1cqhsXxgI+vWwORBiF48guBRrC2J+?=
 =?us-ascii?Q?RSLh9OC20hHMzyHtxT9YJuuln4xm1iVC9UaOteJfLVBW873BRqwT5MNEm1mr?=
 =?us-ascii?Q?Vtsbs4KZmzy7cpUGET8BxHJ77dFmJRuIvtGSJyvYN+eEtku31/VcQSQAzaqY?=
 =?us-ascii?Q?pHvGSn0rGTmYLpRJoGlQ7LdduxLUpjYg1b8v34ZRvyqwvzehmcs3dPn602wr?=
 =?us-ascii?Q?EXb/dQrOalayJgPO7IthdRYV/HIfNkozp5BsrGZXDRvHbSMuS9WQIHHJ9dr0?=
 =?us-ascii?Q?dSy+w6Z/aNg7SdTHWgcjX8NXIVUEhR8jNAdejQIZAOY+KFF4FHhn/UO5gFrz?=
 =?us-ascii?Q?v8wJpItL3eCgmGNdnrr9WzoDXk1TU2b41Dw423sB9K1vitldh5C/StDD/0og?=
 =?us-ascii?Q?i8Q+VFJfYW8YjAICQBaOoJb7e+15ITiRJ4MrRbqs0NDGzkXH/vS9rx4j1Qte?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9hGSuxETYFByWWV8U9q3aE6xiUQ7N1cFLdWQgi1vNml/V+J+XGhpyNXd+f+Z4hO0J7rpoOo8oIzO9P4Shi+W+exTzU5CP21ym09sSoFuWJATCaJ7k+vMhKrwNGCcnPNhXjziZPriVxSr5oYpDYpwf/P+Ml7S27Q2BomTo67dvjBF4CSuKZXxaLFaBW1zM8WheeYAd1Uv8C8173iCuNWZaM5tgQ+yvtvS5Muai0ClKpA5WOBQFz1ulpWSbIgOQrU1pau1PlPPE9JLXJbnlTz4qStmIuoIDcJ/9pbByqsU9JXa0yAlHCsCQGjVci3vMTnl0mbibGNp0GhW9qWWlkNRV5weLNTXt+xQfvJ/YWTugrOISBAjnANZyAlJVZanjwubug0bJtkgabupgtnmXEqgYas1TkCO5SGR7D0Y29sx7YsUAnfdICd4mahXH11NT1l1p2N31tEG/RWvXdkD3wHlnP5lveRWg8BbMA2UCFTKJdLjfZcO+VobUv8IeoR+CtO2hc8ULHVbHSyZdOMeANB2bU5cABdwEWob9b+DMV9WoHiMp7xo1fs+qgmv3GcofC5BwTfAWwtQ3v97w7Kk9tGWP6R2clJpBu92UBy4n3GdwAk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b88e4d-4c66-4b40-5687-08dd4513b6bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:53.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzhD9oDfk0U9icB34Ba72wwnBkzS5O8l5Ms5KBjLTI9YMhZFJC619drIVV6oMDlOQzoHw91d9mDvBbbfE5Gh5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: rHjMy-pvDVScubyChWvqocEaSNn-1bFD
X-Proofpoint-ORIG-GUID: rHjMy-pvDVScubyChWvqocEaSNn-1bFD

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 ++++-
 fs/xfs/xfs_reflink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  3 +++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 12af5cdc3094..170d7891f90d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -527,7 +527,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index dbce333b60eb..60c986300faa 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -990,6 +990,54 @@ xfs_reflink_end_cow(
 		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
 	return error;
 }
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+	bool				commit = false;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
+	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
+
+	resblks = XFS_NEXTENTADD_SPACE_RES(ip->i_mount,
+				(unsigned int)(end_fsb - offset_fsb),
+				XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error)
+		error = xfs_reflink_end_cow_extent_locked(ip, &offset_fsb,
+						end_fsb, tp, &commit);
+
+	if (error || !commit)
+		goto out_cancel;
+
+	if (error)
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
 
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index ef5c8b2398d8..2c3b096c1386 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+		int
+xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


