Return-Path: <linux-fsdevel+bounces-22637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4891AA44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7101C20E33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801C198E73;
	Thu, 27 Jun 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0snu9Nt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nWMj/RVe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAA197A95;
	Thu, 27 Jun 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500605; cv=fail; b=Rg/hNzFxOkXDNabXWFNHlC7VV6zR2qqfzmcaY2CDTihRAgpJAyCnAW+7cLEt0/VWNcNMJSfmTsCuSMH2wE7Ya28nTFFBDbAp9LYM3p+xZjf8XDVTGjFQjCQMrWQfeuMLl7DDHLCR/wufP5O2wXkF9yODwgmlT/TUdMpr9IQF2WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500605; c=relaxed/simple;
	bh=CJiig0dG1L55/lMia6pQ74KQY5rDBGiGlvDGRRn6vZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3LXsMo+VVwRMMIuVRhF9Ox+7itV+DnUnsbJ+TjFROUilZyXOyghZPEH7zHZHPg78MXa5O0vV9XKRbiPq5GBQEKIQ8yap2Z17fCikY72vQkI7BjeNLPTchYQqE8sY8V5gkr84xS1yOuu0CEoar2e0+LZRpYx4KAI2z074ARTI88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n0snu9Nt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nWMj/RVe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45REMVd4007911;
	Thu, 27 Jun 2024 15:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=f2vYF2p2A5OSoLD
	0dW7hWw0esq1w79mt+ykGTE+ClZY=; b=n0snu9NtwdRe3BISum+/CAigfKR6n1A
	RPQAtYV6QbqgcUB5D+EhEQ8cxWQJdP46PA2YCgIz4G8Y0WGhTFvgmYxTPenVup8X
	/aDCKtAqOSxodx/vNcYDZJ9ZJapI167QKm2LAB5OeZc90okwAMltn4+WJREIw4fY
	eNCkw7PZozfWh4pN+Yjv3xkh9op/5P0syVByVkrWfdoV3ykFvV3p+zBKR4jJxxVI
	o/l5TUtxvtkZJ2v5LWFlhINQcYrhEEYdacWtZG2g6nukcNaFkFLSy5Ptm8qAtWvc
	Jq/dMyjN9pPJlN2+/fHqzYr5ED8X9Ee3+1ejxbWRSNzDcV/OuhX7w4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb6a7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 15:02:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RE7JhO021479;
	Thu, 27 Jun 2024 15:02:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys7f5e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 15:02:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdLq8jDswZo6PlzS70UbUSDwRpunMvq4gKfuo+A3Q50IF3NIBOikHd/PQEPW75IY8sp1Aec04ql0LgEUQ1e9y4svFikCknw54nfVbDrQOvbo7XWYkpIsVzYv4PqbAHK9rPaqy+NAz3ktTI+5UouvNi+LHoHUI48x3bhU2ukcwl8Fzdvo9OcISmA9dlZXfMop/mUwM27ps/kd4v28tKswI7tvokzxm+xZObDaRrxjEnq1nHIE3paWjtgXaBHcWUT+N093bnCfZWT4e67MgLLgfliH12UDAVfy4CQQmkGnJxHheXkZV2BYRQ+TxPwr50QXnYc10Erp9PIuhIKG0XHLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2vYF2p2A5OSoLD0dW7hWw0esq1w79mt+ykGTE+ClZY=;
 b=R+p9XsVpEuX5SBngOW7UbpTMv1FTzkZDajdoHC7Xbg/zmbc13FEt9bBh5FKsGHIX+5vptFcQ7giM72n4a6BxkCC2vVyfSrZdwXbcQmOdZ44Wgoy7b21pvy3/PLMjAhgogPoKr4+69tmw/Dx0hzEmFLdewdfrltWNJJ2yATH47S2vN0n4HsoWFtJZbOnQ9z/Xl7xffeI1OI7fLBP6fPqTlNXQyfILX3RbiURoTcZK7/e5y7bkbB9GencyDJ0kvbWWDTu3DIoQHhg+rp2FGGIA9Ms2UYH0n4TXY/xLgPNXjsUakDH4Hiioz7WRxJpbnXBubBh3lI2OsZM8AihcZKn/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2vYF2p2A5OSoLD0dW7hWw0esq1w79mt+ykGTE+ClZY=;
 b=nWMj/RVeuBWU7B6y/WVF3wp12/b/dSQjB5d2+wU1VLC47TQgL+EvRKrxPOOdPB/HDkEG/fnV6uEyyrQxulgs4dVbLDQam2jKX4axNhhRogK9UnHx7BKk6rcHGdFPrPOQVXMKmpojxPM/VqdOKKDb5lyR493IMZ00gvq2kEGD2xY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 15:02:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 15:02:49 +0000
Date: Thu, 27 Jun 2024 11:02:45 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 04/10] fs: add infrastructure for multigrain timestamps
Message-ID: <Zn1/FVS4NrAwEBwz@tissot.1015granger.net>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-4-a189352d0f8f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-mgtime-v1-4-a189352d0f8f@kernel.org>
X-ClientProxiedBy: CH2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:610:5a::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 268c8e96-e244-4a0b-943c-08dc96ba35bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?odmB+ai9jnqKtuTwU2ujdbYsPsFOpX9+44T7kKtM02DOl2UCkJAjfGZTbA9P?=
 =?us-ascii?Q?IMFjT6kA9HI2JUzh8lehuW+iGbVD5PCkFfsiR6xGxgWkHBa9wa1muyd+sCQT?=
 =?us-ascii?Q?zP8EfUhJY0HIBHh/4s+gaD6OCWaC/HmvfsZazmqK3eLkhZF2r5tVcd03M8WD?=
 =?us-ascii?Q?X1FgFfAF+O0+vWgyiVzN60h2/bHJwMRs+pWm6Eisv8tnprXrm9cX6FstArj0?=
 =?us-ascii?Q?0jyyqC17c61bpmE2YXGXsfqs9aRRXiIfV+0OaUzsKjGba5EDGRT3s621NErx?=
 =?us-ascii?Q?WpPKLPnHovQPRPZ6nLbokAfVANAvIV3ZBiOD3SvhTORVuqMr3eW/FR3s2o4x?=
 =?us-ascii?Q?7EW3yoXHTWM1Prn95mlGHgdNccFiSHbfCElNw5y9IUmOpwhzFPYRvmwv/1zo?=
 =?us-ascii?Q?AomslDXHw4z4bDezBvPeZ+9opx4ziZfQBim3Altv8M1iOphdD5Ww/tXM8xmp?=
 =?us-ascii?Q?OMp1EKn5n3C/pjCsD86AUwpXqWgFzjGpSjKk4F8EJMipvhkD2uOsK8OBQyO5?=
 =?us-ascii?Q?aTG8CswToBVrLxru45WtmBZHcSLNcf1DisuLt72g9/7zvyjhHp+qCmvyZL/G?=
 =?us-ascii?Q?FdHHlCQg1XxoQsxxAFMJVOHwNkJ2/9k2CxtCmsFzNZghmUCO8O5X2cXHfAGl?=
 =?us-ascii?Q?zndRuLy1jY3MzI4MAqsOUw+ZspGL+OKsklO7NFUX9/scVPw2GJ6VqGdY117V?=
 =?us-ascii?Q?1ksjVqULkLk9tJollbYXY2QRt041UK4SqUGTI54QV0iEONYhTUpHzXB7svoz?=
 =?us-ascii?Q?7yflv7ou1bWDWevZ7BU5a0S+/CHk6JMG/RW4Iwfxpn+iNDfliST2K7qe3F5o?=
 =?us-ascii?Q?SjCtG2rrdFeEDOgZL08xX/fiqhWSzz3ASyQjXSbUqrhvIyMH+Ukad7mA569B?=
 =?us-ascii?Q?2z7YUx4wjuUaBHonvvUyNLDaTJQ1oZJFKdaN8hyRvunEG1hJx0g0DRx5EP1z?=
 =?us-ascii?Q?Ziq8g7vgvqykCGx8Xbqq0BXm1jYed+qbnvVRL4svS7XaXqYf3hDgaqtPzr5p?=
 =?us-ascii?Q?z2ktxE2GtwLJyiDtQa/SoiRFble+WhudnHCSsXPt0XL6QUVWQUsflHbr/MwR?=
 =?us-ascii?Q?kOYM8EO+lR+VZ0KofREUlcI9nochD3V9uMgiEG6pr6sHQ8dudkD0DwJ3cr/d?=
 =?us-ascii?Q?muqwjNCfGdQSusX/qSgbAnd+ypIJtSkxh1WnKp4OjepEINxbQ0UWTtjB41pK?=
 =?us-ascii?Q?BdIDeAqMgRNanAzJ7MAFJSFTVZdW7/JRQ+zeXaatfnh5NhK0yTpNxhh8712k?=
 =?us-ascii?Q?V1bxvzg2ToI0fj8sEq0+5tSyd63YVe4jb/UU44rzhwAI2/MHlqAWuNuh8amO?=
 =?us-ascii?Q?BefE6svPjiekL6g0oc/x0qgc+vRuwGPMXyFG4f/OCG9B5Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gmzhCiD3ufK0gIJ9gT20EoVhczf5stgvWLl4mwmZbYYFZa4XVNsII2LHFe6w?=
 =?us-ascii?Q?3oFUmgPfD+GurGrDaF12pXIRxfIYXTSixf5newRJA7OPdXVAcOXDTimEY1Fl?=
 =?us-ascii?Q?aCtXon1rP3z2YS+r8ewQCCZWqveCue7W8n9bvHX+HOgYpJTTnHrUIe6+xjsu?=
 =?us-ascii?Q?uJfWZMtoXFSmx3oNTXO6tZXkle14kPbwSL2+4dgW+syKmorwZO5xFCxQBg4C?=
 =?us-ascii?Q?nm+Zwk/1vTEGW8PaE7+bji5e86MaJIli6GWczct/31j0aUF2XvqKF0dGnKSK?=
 =?us-ascii?Q?CB4cwCWWG6JPs9fmnzMg9gom6uChU3C65Gd6A0m0/4vbcJMRbotH0x/jOsLH?=
 =?us-ascii?Q?gb1Y7ejyhSXfEpE9YFbzxsseSyGTf7VQ/G5vIb2pFHgS78Qmv695oDpcJfM1?=
 =?us-ascii?Q?nRa0gSKLNU7HwXZs3WfFKr7aN+LrOL6pWDCl+BVInlUtrO+AVitybIehg/u/?=
 =?us-ascii?Q?VkwK/NFkWgta2Xwjyc9CX4ej/aI/GbQBzEW7u5VTuXtGckGNocwUuc7hxvxS?=
 =?us-ascii?Q?2aZzOoxukmgamPi7+AUdbQSeFZGku0lj11wCbV4KkhFAtmCAuLCb2hCB1W1l?=
 =?us-ascii?Q?HMxfC9q6O30dVZbPKS3aEY1V233TTznr1rwLIIe/NHq/oB+2EGbcAZTv9yuW?=
 =?us-ascii?Q?BTaoIpc8ycgqIDJDLqqJfrj8KcDE9Wz0ED2acJ8CJf/d0SCF5I2S/e+RG0aW?=
 =?us-ascii?Q?a5mxGjY/cZnzJxXp50IWxf1t/gNpgtDui/tPsaFXpqqWFA9lYzcrLlGe02X6?=
 =?us-ascii?Q?9DTetrig7R6FxuUXtDcQ9TgAFSDvSzv76hBe+QgEM5nDiygAgSgfNO08EHcv?=
 =?us-ascii?Q?qfuhAZV1BSVeKL95ezLi4yCptlwz4CgLfKvF7OyJqHoZWZ3t/WZ/E1IZzNCn?=
 =?us-ascii?Q?XJ3wptc8bp2pQ+sgmjngIU6qQVsg+KY12qAgDBSniF3Fouz3kE4NBATG3/PA?=
 =?us-ascii?Q?/GCzMO2IRHEPkQCUv1INu6CAMVIJLfe2TfxeM2eSk8D+SJL/FxA6EpfCwDyZ?=
 =?us-ascii?Q?pzTvMFqKB00jSJiWXUFO7cg2bmcbNdjIJaobylWcYgQOddisJ+gdnqh4Jlhf?=
 =?us-ascii?Q?Mgfv8GhG/ck7cmK07IPYkqFH0aapKvYKE+s6Dw/WxklgBsN/mUQgvtZxO0jg?=
 =?us-ascii?Q?ZYS/pfBdpG5xQpGu+RjnB+DxllmvoWIRA2NtGiadU3QRhmw/H6iGm/ZfWNAF?=
 =?us-ascii?Q?3lKoaVe3nKk1+CiPSv0pBEzYYV8Msg2Lw485U6jwKnODeOGdxNE5O++SC6cd?=
 =?us-ascii?Q?68ogqpoFJoSewuazexl/ahy6xL7kAq5oT9c0qzx/2bBgfc6t8CtHpENftrij?=
 =?us-ascii?Q?Prb0OUFGi0XZjOSHbeHdZQPhu6xBV0BMVnq3xFiiZ5r93n9saSxveL+zYU5+?=
 =?us-ascii?Q?A9eS98GdZgoNCGbeXsrfWAUguNTeizyPizxO57jUrCnt9vsEsPsVXb/mBMR2?=
 =?us-ascii?Q?0yDQu3WJ2xFJ2RF7zDmjJhSFXjykvWtTBo06quZR2SAIkkasdMkjJ6JhZSJ2?=
 =?us-ascii?Q?5fvYqfAe94cH5TXKF3tIKFWrqeF6Gm31CTs0j85SUAbhRoq21kCNN0Qw3EN3?=
 =?us-ascii?Q?Ie7mxd5lLCFjILT3NxxdeUSldvmodBbcCZNz1f0X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZhToWDqrsIX8YandF7jgYTRYXECq2Ke1zSEok6IydOMlzwoUwiExjgTJE5FtL8ZIZBUJOsWODXodgvXJxMBmyd1cf7AQsDrXs1m+q9xtjHL+0jIYkKNG2wCeRtix3aZgaOnMTSKHbb/aNoSHLzMCZSWxFZjdXCsOzaWtMF0etOGFK+0ImBTCoMVEPISMqaia+34/l5idg+mDieC6bGl8HiM75A+b5j5+8RatssSv5jOJbR0SBiykUt7PBODSIvwggA0w45diEIJwVwMk3LuBVD0U188X0BfLo2Y69e2J4NzcHiM+nLV3JKqLpf3AVSsXj5yKmRlTXmUGGOIfoIchFFN3VdijZleAJEVXDhiqOUQ/6k+gvH/4WfkGVKIlDEa8C4kKy7sLsvv/dboJfpEg+26UEQaIBPCWu13+cMX7UWwX2vX0sUMp+IoU3UCrC0Esoh5WgXXeEwsQqTkFtancgRsB5TbtxEjqGCvFs/t4MfA5Dka5DivohqeognZd/rrnJibgSKZrYYivHAYjx7rZ/5yXp0YA72E18SwmNplD2Tb2ePApzuK9suv2S6iTg9pbFwOaKtC8VyVHCMHEFVd7ouctu05gczgHLhBPjXhll7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268c8e96-e244-4a0b-943c-08dc96ba35bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:02:49.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNDA5Jrt8KEhPEKksqnOMu4jgbfhjix6OvG/SPOMYZwcUv1Q9ntMB1VUK7GR0cq+WB2DwP5irzoV4Fy11WgTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270114
X-Proofpoint-GUID: K7hpY-prULX9jufmzDNqfOhOgCi2nuGo
X-Proofpoint-ORIG-GUID: K7hpY-prULX9jufmzDNqfOhOgCi2nuGo

On Wed, Jun 26, 2024 at 09:00:24PM -0400, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamps when updating the ctime
> and mtime after a change. This has the benefit of allowing filesystems
> to optimize away a lot metadata updates, down to around 1 per jiffy,
> even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. A lot of changes
> can happen in a jiffy, so timestamps aren't sufficient to help the
> client decide to invalidate the cache. Even with NFSv4, a lot of
> exported filesystems don't properly support a change attribute and are
> subject to the same problems with timestamp granularity. Other
> applications have similar issues with timestamps (e.g backup
> applications).
> 
> If we were to always use fine-grained timestamps, that would improve the
> situation, but that becomes rather expensive, as the underlying
> filesystem would have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried. Now that the ctime is stored as a ktime_t, we
> can sacrifice the lowest bit in the word to act as a flag marking
> whether the current timestamp has been queried via stat() or the like.
> 
> This solves the problem of being able to distinguish the timestamp
> between updates, but introduces a new problem: it's now possible for a
> file being changed to get a fine-grained timestamp and then a file that
> was altered later to get a coarse-grained one that appears older than
> the earlier fine-grained time. To remedy this, keep a global ktime_t
> value that acts as a timestamp floor.
> 
> When we go to stamp a file, we first get the latter of the current floor
> value and the current coarse-grained time (call this "now"). If the
> current inode ctime hasn't been queried then we just attempt to stamp it
> with that value using a cmpxchg() operation.
> 
> If it has been queried, then first see whether the current coarse time
> appears later than what we have. If it does, then we accept that value.
> If it doesn't, then we get a fine-grained time and try to swap that into
> the global floor. Whether that succeeds or fails, we take the resulting
> floor time and try to swap that into the ctime.
> 
> There is still one remaining problem:
> 
> All of this works as long as the realtime clock is monotonically
> increasing. If the clock ever jumps backwards, then we could end up in a
> situation where the floor value is "stuck" far in advance of the clock.
> 
> To remedy this, sanity check the floor value and if it's more than 6ms
> (~2 jiffies) ahead of the current coarse-grained clock, disregard the
> floor value, and just accept the current coarse-grained clock.
> 
> Filesystems opt into this by setting the FS_MGTIME fstype flag.  One
> caveat: those that do will always present ctimes that have the lowest
> bit unset, even when the on-disk ctime has it set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c                       | 168 +++++++++++++++++++++++++++++++++------
>  fs/stat.c                        |  39 ++++++++-
>  include/linux/fs.h               |  30 +++++++
>  include/trace/events/timestamp.h |  97 ++++++++++++++++++++++
>  4 files changed, 306 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 5d2b0dfe48c3..12790a26102c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -62,6 +62,8 @@ static unsigned int i_hash_shift __ro_after_init;
>  static struct hlist_head *inode_hashtable __ro_after_init;
>  static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
>  
> +/* Don't send out a ctime lower than this (modulo backward clock jumps). */
> +static __cacheline_aligned_in_smp ktime_t ctime_floor;

This is piece of memory that will be hit pretty hard (and you
obviously recognize that because of the alignment attribute).

Would it be of any benefit to keep a distinct ctime_floor in each
super block instead?


>  /*
>   * Empty aops. Can be used for the cases where the user does not
>   * define any of the address_space operations.
> @@ -2077,19 +2079,86 @@ int file_remove_privs(struct file *file)
>  }
>  EXPORT_SYMBOL(file_remove_privs);
>  
> +/*
> + * The coarse-grained clock ticks once per jiffy (every 2ms or so). If the
> + * current floor is >6ms in the future, assume that the clock has jumped
> + * backward.
> + */
> +#define CTIME_FLOOR_MAX_NS	6000000
> +
> +/**
> + * coarse_ctime - return the current coarse-grained time
> + * @floor: current ctime_floor value
> + *
> + * Get the coarse-grained time, and then determine whether to
> + * return it or the current floor value. Returns the later of the
> + * floor and coarse grained time, unless the floor value is too
> + * far into the future. If that happens, assume the clock has jumped
> + * backward, and that the floor should be ignored.
> + */
> +static ktime_t coarse_ctime(ktime_t floor)
> +{
> +	ktime_t now = ktime_get_coarse_real() & ~I_CTIME_QUERIED;
> +
> +	/* If coarse time is already newer, return that */
> +	if (ktime_before(floor, now))
> +		return now;
> +
> +	/* Ensure floor is not _too_ far in the future */
> +	if (ktime_after(floor, now + CTIME_FLOOR_MAX_NS))
> +		return now;
> +
> +	return floor;
> +}
> +
> +/**
> + * current_time - Return FS time (possibly fine-grained)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
> + * as having been QUERIED, get a fine-grained timestamp.
> + */
> +struct timespec64 current_time(struct inode *inode)
> +{
> +	ktime_t ctime, floor = smp_load_acquire(&ctime_floor);
> +	ktime_t now = coarse_ctime(floor);
> +	struct timespec64 now_ts = ktime_to_timespec64(now);
> +
> +	if (!is_mgtime(inode))
> +		goto out;
> +
> +	/* If nothing has queried it, then coarse time is fine */
> +	ctime = smp_load_acquire(&inode->__i_ctime);
> +	if (ctime & I_CTIME_QUERIED) {
> +		/*
> +		 * If there is no apparent change, then
> +		 * get a fine-grained timestamp.
> +		 */
> +		if ((now | I_CTIME_QUERIED) == ctime) {
> +			ktime_get_real_ts64(&now_ts);
> +			now_ts.tv_nsec &= ~I_CTIME_QUERIED;
> +		}
> +	}
> +out:
> +	return timestamp_truncate(now_ts, inode);
> +}
> +EXPORT_SYMBOL(current_time);
> +
>  static int inode_needs_update_time(struct inode *inode)
>  {
> +	struct timespec64 now, ts;
>  	int sync_it = 0;
> -	struct timespec64 now = current_time(inode);
> -	struct timespec64 ts;
>  
>  	/* First try to exhaust all avenues to not sync */
>  	if (IS_NOCMTIME(inode))
>  		return 0;
>  
> +	now = current_time(inode);
> +
>  	ts = inode_get_mtime(inode);
>  	if (!timespec64_equal(&ts, &now))
> -		sync_it = S_MTIME;
> +		sync_it |= S_MTIME;
>  
>  	ts = inode_get_ctime(inode);
>  	if (!timespec64_equal(&ts, &now))
> @@ -2485,25 +2554,6 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
>  }
>  EXPORT_SYMBOL(timestamp_truncate);
>  
> -/**
> - * current_time - Return FS time
> - * @inode: inode.
> - *
> - * Return the current time truncated to the time granularity supported by
> - * the fs.
> - *
> - * Note that inode and inode->sb cannot be NULL.
> - * Otherwise, the function warns and returns time without truncation.
> - */
> -struct timespec64 current_time(struct inode *inode)
> -{
> -	struct timespec64 now;
> -
> -	ktime_get_coarse_real_ts64(&now);
> -	return timestamp_truncate(now, inode);
> -}
> -EXPORT_SYMBOL(current_time);
> -
>  /**
>   * inode_get_ctime - fetch the current ctime from the inode
>   * @inode: inode from which to fetch ctime
> @@ -2518,12 +2568,18 @@ struct timespec64 inode_get_ctime(const struct inode *inode)
>  {
>  	ktime_t ctime = inode->__i_ctime;
>  
> +	if (is_mgtime(inode))
> +		ctime &= ~I_CTIME_QUERIED;
>  	return ktime_to_timespec64(ctime);
>  }
>  EXPORT_SYMBOL(inode_get_ctime);
>  
>  struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
>  {
> +	trace_inode_set_ctime_to_ts(inode, &ts);
> +
> +	if (is_mgtime(inode))
> +		ts.tv_nsec &= ~I_CTIME_QUERIED;
>  	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
>  	trace_inode_set_ctime_to_ts(inode, &ts);
>  	return ts;
> @@ -2535,14 +2591,74 @@ EXPORT_SYMBOL(inode_set_ctime_to_ts);
>   * @inode: inode
>   *
>   * Set the inode->i_ctime to the current value for the inode. Returns
> - * the current value that was assigned to i_ctime.
> + * the current value that was assigned to i_ctime. If this is a not
> + * multigrain inode, then we just set it to whatever the coarse time is.
> + *
> + * If it is multigrain, then we first see if the coarse-grained
> + * timestamp is distinct from what we have. If so, then we'll just use
> + * that. If we have to get a fine-grained timestamp, then do so, and
> + * try to swap it into the floor. We accept the new floor value
> + * regardless of the outcome of the cmpxchg. After that, we try to
> + * swap the new value into __i_ctime. Again, we take the resulting
> + * ctime, regardless of the outcome of the swap.
>   */
>  struct timespec64 inode_set_ctime_current(struct inode *inode)
>  {
> -	struct timespec64 now = current_time(inode);
> +	ktime_t ctime, now, cur, floor = smp_load_acquire(&ctime_floor);
> +
> +	now = coarse_ctime(floor);
>  
> -	inode_set_ctime_to_ts(inode, now);
> -	return now;
> +	/* Just return that if this is not a multigrain fs */
> +	if (!is_mgtime(inode)) {
> +		inode->__i_ctime = now;
> +		goto out;
> +	}
> +
> +	/*
> +	 * We only need a fine-grained time if someone has queried it,
> +	 * and the current coarse grained time isn't later than what's
> +	 * already there.
> +	 */
> +	ctime = smp_load_acquire(&inode->__i_ctime);
> +	if ((ctime & I_CTIME_QUERIED) && !ktime_after(now, ctime & ~I_CTIME_QUERIED)) {
> +		ktime_t old;
> +
> +		/* Get a fine-grained time */
> +		now = ktime_get_real() & ~I_CTIME_QUERIED;
> +
> +		/*
> +		 * If the cmpxchg works, we take the new floor value. If
> +		 * not, then that means that someone else changed it after we
> +		 * fetched it but before we got here. That value is just
> +		 * as good, so keep it.
> +		 */
> +		old = cmpxchg(&ctime_floor, floor, now);
> +		trace_ctime_floor_update(inode, floor, now, old);
> +		if (old != floor)
> +			now = old;
> +	}
> +retry:
> +	/* Try to swap the ctime into place. */
> +	cur = cmpxchg(&inode->__i_ctime, ctime, now);
> +	trace_ctime_inode_update(inode, ctime, now, cur);
> +
> +	/* If swap occurred, then we're done */
> +	if (cur != ctime) {
> +		/*
> +		 * Was the change due to someone marking the old ctime QUERIED?
> +		 * If so then retry the swap. This can only happen once since
> +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> +		 * with a new ctime.
> +		 */
> +		if (!(ctime & I_CTIME_QUERIED) && (ctime | I_CTIME_QUERIED) == cur) {
> +			ctime = cur;
> +			goto retry;
> +		}
> +		/* Otherwise, take the new ctime */
> +		now = cur & ~I_CTIME_QUERIED;
> +	}
> +out:
> +	return timestamp_truncate(ktime_to_timespec64(now), inode);
>  }
>  EXPORT_SYMBOL(inode_set_ctime_current);
>  
> diff --git a/fs/stat.c b/fs/stat.c
> index 6f65b3456cad..7e9bd16b553b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -22,10 +22,39 @@
>  
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> +#include <trace/events/timestamp.h>
>  
>  #include "internal.h"
>  #include "mount.h"
>  
> +/**
> + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @stat: where to store the resulting values
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will ensure a distinct timestamp.
> + */
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
> +{
> +	atomic_long_t *pc = (atomic_long_t *)&inode->__i_ctime;
> +
> +	/* If neither time was requested, then don't report them */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime.tv_sec = inode->i_mtime_sec;
> +	stat->mtime.tv_nsec = inode->i_mtime_nsec;
> +	stat->ctime = ktime_to_timespec64(atomic_long_fetch_or(I_CTIME_QUERIED, pc) &
> +						~I_CTIME_QUERIED);
> +	trace_fill_mg_cmtime(inode, atomic_long_read(pc));
> +}
> +EXPORT_SYMBOL(fill_mg_cmtime);
> +
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:		idmap of the mount the inode was found from
> @@ -58,8 +87,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  	stat->rdev = inode->i_rdev;
>  	stat->size = i_size_read(inode);
>  	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	if (is_mgtime(inode)) {
> +		fill_mg_cmtime(stat, request_mask, inode);
> +	} else {
> +		stat->ctime = inode_get_ctime(inode);
> +		stat->mtime = inode_get_mtime(inode);
> +	}
> +
>  	stat->blksize = i_blocksize(inode);
>  	stat->blocks = inode->i_blocks;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4b10db12725d..5694cb6c4dc2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1608,6 +1608,23 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>  	return inode_set_mtime_to_ts(inode, ts);
>  }
>  
> +/*
> + * Multigrain timestamps
> + *
> + * Conditionally use fine-grained ctime and mtime timestamps when there
> + * are users actively observing them via getattr. The primary use-case
> + * for this is NFS clients that use the ctime to distinguish between
> + * different states of the file, and that are often fooled by multiple
> + * operations that occur in the same coarse-grained timer tick.
> + *
> + * We use the least significant bit of the ktime_t to track the QUERIED
> + * flag. This means that filesystems with multigrain timestamps effectively
> + * have 2ns resolution for the ctime, even if they advertise 1ns s_time_gran.
> + */
> +#define I_CTIME_QUERIED		(1LL)
> +
> +static inline bool is_mgtime(const struct inode *inode);
> +
>  struct timespec64 inode_get_ctime(const struct inode *inode);
>  struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts);
>  
> @@ -2477,6 +2494,7 @@ struct file_system_type {
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> +#define FS_MGTIME		64	/* FS uses multigrain timestamps */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> @@ -2500,6 +2518,17 @@ struct file_system_type {
>  
>  #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
>  
> +/**
> + * is_mgtime: is this inode using multigrain timestamps
> + * @inode: inode to test for multigrain timestamps
> + *
> + * Return true if the inode uses multigrain timestamps, false otherwise.
> + */
> +static inline bool is_mgtime(const struct inode *inode)
> +{
> +	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +}
> +
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data,
>  	int (*fill_super)(struct super_block *, void *, int));
> @@ -3234,6 +3263,7 @@ extern void page_put_link(void *);
>  extern int page_symlink(struct inode *inode, const char *symname, int len);
>  extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
>  void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
> diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
> index 35ff875d3800..1f71738aa38c 100644
> --- a/include/trace/events/timestamp.h
> +++ b/include/trace/events/timestamp.h
> @@ -8,6 +8,78 @@
>  #include <linux/tracepoint.h>
>  #include <linux/fs.h>
>  
> +TRACE_EVENT(ctime_floor_update,
> +	TP_PROTO(struct inode *inode,
> +		 ktime_t old,
> +		 ktime_t new,
> +		 ktime_t cur),
> +
> +	TP_ARGS(inode, old, new, cur),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,				dev)
> +		__field(ino_t,				ino)
> +		__field(ktime_t,			old)
> +		__field(ktime_t,			new)
> +		__field(ktime_t,			cur)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->old		= old;
> +		__entry->new		= new;
> +		__entry->cur		= cur;
> +	),
> +
> +	TP_printk("ino=%d:%d:%lu old=%llu.%lu new=%llu.%lu cur=%llu.%lu swp=%c",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> +		ktime_to_timespec64(__entry->old).tv_sec,
> +		ktime_to_timespec64(__entry->old).tv_nsec,
> +		ktime_to_timespec64(__entry->new).tv_sec,
> +		ktime_to_timespec64(__entry->new).tv_nsec,
> +		ktime_to_timespec64(__entry->cur).tv_sec,
> +		ktime_to_timespec64(__entry->cur).tv_nsec,
> +		(__entry->old == __entry->cur) ? 'Y' : 'N'
> +	)
> +);
> +
> +TRACE_EVENT(ctime_inode_update,
> +	TP_PROTO(struct inode *inode,
> +		 ktime_t old,
> +		 ktime_t new,
> +		 ktime_t cur),
> +
> +	TP_ARGS(inode, old, new, cur),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,				dev)
> +		__field(ino_t,				ino)
> +		__field(ktime_t,			old)
> +		__field(ktime_t,			new)
> +		__field(ktime_t,			cur)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->old		= old;
> +		__entry->new		= new;
> +		__entry->cur		= cur;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld old=%llu.%ld new=%llu.%ld cur=%llu.%ld swp=%c",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> +		ktime_to_timespec64(__entry->old).tv_sec,
> +		ktime_to_timespec64(__entry->old).tv_nsec,
> +		ktime_to_timespec64(__entry->new).tv_sec,
> +		ktime_to_timespec64(__entry->new).tv_nsec,
> +		ktime_to_timespec64(__entry->cur).tv_sec,
> +		ktime_to_timespec64(__entry->cur).tv_nsec,
> +		(__entry->old == __entry->cur ? 'Y' : 'N')
> +	)
> +);
> +
>  TRACE_EVENT(inode_needs_update_time,
>  	TP_PROTO(struct inode *inode,
>  		 struct timespec64 *now,
> @@ -70,6 +142,31 @@ TRACE_EVENT(inode_set_ctime_to_ts,
>  		__entry->ts_sec, __entry->ts_nsec
>  	)
>  );
> +
> +TRACE_EVENT(fill_mg_cmtime,
> +	TP_PROTO(struct inode *inode,
> +		 ktime_t ctime),
> +
> +	TP_ARGS(inode, ctime),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,			dev)
> +		__field(ino_t,			ino)
> +		__field(ktime_t,		ctime)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->ctime		= ctime;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld ctime=%llu.%lu",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> +		ktime_to_timespec64(__entry->ctime).tv_sec,
> +		ktime_to_timespec64(__entry->ctime).tv_nsec
> +	)
> +);
>  #endif /* _TRACE_TIMESTAMP_H */
>  
>  /* This part must be outside protection */
> 
> -- 
> 2.45.2
> 
> 

-- 
Chuck Lever

