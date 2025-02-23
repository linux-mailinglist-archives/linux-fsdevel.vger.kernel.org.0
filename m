Return-Path: <linux-fsdevel+bounces-42355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589CA40D60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1777216FC71
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68711FCF5B;
	Sun, 23 Feb 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FiRTl/7U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SMdK2vt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98771DAC81
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298899; cv=fail; b=A34CiTutImIm0tG7UOvT2cc9N6IVrI3QBI2K1Lb87kOX51g4mpiPuf/TAOSfRoQuVjCjo11bL8Z/2pQI8oSxupSuRfevN1Llvzj8V5/c84ZMUNoX2QFa759QaUIozhId22vBhqVxuA9sfWQfjquUG8P/fIDqe/bliYoAX8+z/GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298899; c=relaxed/simple;
	bh=DKCDOXUzlgVr6/W0FhyvwOX8kjXM7Ms8198YI+UeqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CnGiSU8Fm9e1AhuBK6tO+JrkyYDrtxmrl0s3KoElqPADiuNIaLELxlAZo3duAndHhticvkeSUfBnYPPJ8hOxiUuTjTFTzOz1SuBCChYxTLB8vNwnbnFAgem/blm3zpw+Mq4o/TX2wLB975xPJkdPVqB43R/YowJiTTw0qvGqguQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FiRTl/7U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SMdK2vt8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N5aDvY005138;
	Sun, 23 Feb 2025 08:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+gXc9txnHvbjdsggUu
	Bl1RVuDAYgcLwLtR32dSkp3lM=; b=FiRTl/7UdVllhVC/lIF0NPZ9ozZRuxtvhg
	S/i0R2QAhDTzExuTqBJLsmziwf+xcwGYIufHp3/gfoOR4NCAIZsZ+1CzOGYVWmsQ
	VwU2y9RekOEix8io+eVoFfR+oDbkRDob4LxFRBGWFHRQbHkDy0Z4mAWQY9+0p9sM
	fvTjI3dPkxvCEP5wQJ+yyJ/ou1LdsjZh/vcF5xX2isbAdMWIMVf9JuFyIVVkIgwV
	vU5vqOz86TpTMhRAdYPmuUkBZVv4YkzVa1ktPvEYxSP3TLRS/Z10dAeVLXFtElxt
	A0fixt3+dGbGpz+jEh18ypP+TiMZ1IS5afuoD2eOhCyyl73jNI6Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c28y8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 08:21:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51N68PBW025467;
	Sun, 23 Feb 2025 08:21:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51d3j9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 08:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFpShFwHA6pNz7UDsy3WWc97GKJKoVtc/Wg3obbCcrwo+e72pGSy8hhTyYT6UtLntpRms9XrYTNRoD99A3XpBS80nheNt5MC/mgGf/S6VnpK8QFJDeybVIvGLOac7K7XouiN0veEWHloNLg5KvAdoW0yaP8mavuYkYHtFvM7eBBxELzpCu256AWw0IAWwL7H+bumPcEEGc++TERxywCK/DtcX6Pn7SHYVk7z/pW+PWX+HHbyYC6+ebv5Ti/qrabqHc5tLV0QotuHgeMZr/5n6HXnemUcxttFBUqYUADnsqpSxDiItrd/ZXEiaYwq4D+o5mCT0gd8sZ/1sPOz74ugGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gXc9txnHvbjdsggUuBl1RVuDAYgcLwLtR32dSkp3lM=;
 b=jqLt0/8ZQVxTaVw5yeSYddH70kzcI7lJSw9350y6ot4WKs1j84JzrFolxhQEXVqL0MttiEJ2958C3d/28kAoLN8tuRJirHjC31t8FeQ/hODczAC59hVWhX5IYJ7nun4a9Tq8UCZVxdX6wbUaCXfHdsahKg6le3Qg4fSAOAYq2w+IvqbV7RnGV6Lh5Y4S5FfBWeltWv+WBZdPTelDknri/Cyg1MhbBt2KB4LACj14OHeOycicXhEACSF0sQH28HnuFX78qWseHPQmmqlgKOw1QyTJjPff8j76Yejfh060PHtl8yaK9GxMNluGrJqMyt5f7VI3j1LzQ/u3VE4uPunFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gXc9txnHvbjdsggUuBl1RVuDAYgcLwLtR32dSkp3lM=;
 b=SMdK2vt8Jv64zKq8meXtBYiyy4gug+6EJBegaWaqCISkuzw02bPf8mdHffw+9rsuKhATc6oXIBn2LqjJqF9MP404m8I7i6UY4YsXNWfDuhDahd4MuTfkrNj/2xYDlrmor3eZIdaunyubte39nyspNFSV3Mz5sfOjyQamTVn1WKk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7864.namprd10.prod.outlook.com (2603:10b6:610:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 08:21:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 08:21:19 +0000
Date: Sun, 23 Feb 2025 08:21:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <b2f83ad1-1a2a-46c4-8708-dd4025dfc2e5@lucifer.local>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
 <8763a109-a687-4e1e-a6d8-9b163031b77d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8763a109-a687-4e1e-a6d8-9b163031b77d@arm.com>
X-ClientProxiedBy: LO2P265CA0382.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::34) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: c5462de8-5abc-4814-b904-08dd53e30d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBD6wng2qcRYgSXbpYx8DIz1Ck6n7EdhAH7p9Kd1N+kvo38EA7ieMdPuavl1?=
 =?us-ascii?Q?RpaBOzY/YR0CI9NAUWNb20Ide93uybZXa0KDLbqp3wEgFe1FQbel1N+Khh1Y?=
 =?us-ascii?Q?O7sDYUTMbHp8pDkPjuTcxLziMacm/6FpLOTbaSZQM9pkwcujn273FSGcsojR?=
 =?us-ascii?Q?99UU3zeO+r0FSQq1uoaUy8HyasWcm1cPBhTy3b4wQOHL5YbYrF2qPVMjWpNe?=
 =?us-ascii?Q?+HvZPxtaoq3QJk8jGgtKC57+izfsNd4ohG7qlDsWG7GLbFhkHh84/J/IEjyo?=
 =?us-ascii?Q?rQsqvXrqtE9LdHCBN57o14xe6FvfVqZJ87PttKAEy4qCjkHih7EAhdzZq01s?=
 =?us-ascii?Q?EVPFKjxFIFd2f0UbwKIK87Buh/KlUjirFP694mklw2rI8rQeLqIViW9teuzK?=
 =?us-ascii?Q?X1LN/jTpwavZs0xVkVcvRh3w7VvVPVBku818u5UefjtxqN+SpIBPYpIC+f0d?=
 =?us-ascii?Q?QA7b3sEtPzEySPgFMLGXIDvx+nb44rAeTyzsN+uJSpWqi3isOC9xApm7trVi?=
 =?us-ascii?Q?7vlxwzBOGwcx+qxWwexfNl5regOeHc6RFX7FEqJ0QMEDfpNFarVq/iyVtCZ2?=
 =?us-ascii?Q?dwCZb/KcZ2EtkItDBOEB374MGoKl5T9uGYdrOJKVGwCRH1ndEo4yo0xLtFCc?=
 =?us-ascii?Q?mACCaKABQbE23u2Sg1BQ8CUfCltYznLYOYr94uFFDKaqWQNpkonTnP5ztVha?=
 =?us-ascii?Q?CwUuUS66e/6w3M40D3Eyj3eooWmLz8p42uDivu21isFNXwjoO0Nfrk/Rx/2s?=
 =?us-ascii?Q?c/S/t/gBX2o57+WAEg2ci/H+44QKs89Yi2wNhE2pGl2ab6iNwxaBkiu7Rfki?=
 =?us-ascii?Q?RAYpK0C+lwtQTUWcmd7cnktFOBi/5a24Dgd3UJhU0UA07m2ENrNrfLDuVP/l?=
 =?us-ascii?Q?N89ivlyQbE4C3pokPjonR+xoVgR0Smu4l/xutXeSK8zZPoCoZwg1EsR2bzqm?=
 =?us-ascii?Q?hK2Yr0d+0d94ok3WXpmgUBTB5eAOQv4EoMYJ3NppohgFGPy6qrZuaDo4HS0H?=
 =?us-ascii?Q?sA3H8Br4V5s1MltZXUfFGnsBjtURI6fTvaxirO2OZ48ykKJN9EgvYJ4uA7uF?=
 =?us-ascii?Q?zBoukZyJ1wNDPeCqSiBr7TWzDI/Twbo5HN+nozOeeW//FMhGcxATKGwI9O9y?=
 =?us-ascii?Q?8lxbVOVaXAm2jfUHYtsiisd9ZDYuDovU4aBkpNrVMzFUicQrHSKZOZv+TEYS?=
 =?us-ascii?Q?6qb7Af/ts29OKkh1XrONC4HkF7u9aYHeX3CTigH6MtaJnoNnqYuLpWSXgUwU?=
 =?us-ascii?Q?E2Pje1L0jubIaFIEyQ2SECvUE9utRWbt4AeQJI2Flrt1LUFhKbAm3/Mb4jBW?=
 =?us-ascii?Q?pUDQGqyaf3zthStTWmNZVb7P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WyXGbJdYXCVkTPFRP6EsERottq4RJk25VTm1BZDJspcIWg8CK4sd7Z83Pb/+?=
 =?us-ascii?Q?hP4j3Jy+RkeMQmegjmG2rcXd7GW0Ka/uN7CnVf/EqjXCLvNtGqOUjKFu0qh5?=
 =?us-ascii?Q?znTD6hWSZfFtPO5GGyL8Yf8dGid0bhNArRThxNWOhLL5ftzgHvr6S5sehJXU?=
 =?us-ascii?Q?ZnaW5n1IAf+Gw7j4uB5OzxjTuOwXoNHcSxpthy19v30xJ3svYzgEsxXXkHPc?=
 =?us-ascii?Q?7IEq2InvAoLAMht4qO+PwSs2SjNRQFl2zTwiVtjUs3KKullWzXqkGDmOLHgW?=
 =?us-ascii?Q?4IRmPt/RNOJJS/YC0AvkS1z59os0bi0O3jwkli7gYN8lC5pjRuYMQz6jrKqc?=
 =?us-ascii?Q?joQFLoOgPb6dQlc9UxzxmI7XNXiqggWWb9HE+GUG8EWj342mXnbnALLTtWog?=
 =?us-ascii?Q?wjyyT4rSyhmWceJRH/kl+RUArR+aa8GCEIy69+a5gVkvQ6A02tOflV/KQbPt?=
 =?us-ascii?Q?1IgbiRa5v19qw/uii/rNCi6kmIlzBuVQR5ZS692xQzEpIkiNUxFgAOoqKj1q?=
 =?us-ascii?Q?kZqGi5WBsaM0C8yZk8LszU1A3fUeXAYaqUMHISTN801PMmnDW3my5mRWzcYo?=
 =?us-ascii?Q?or26fChC7NcgkfQ8P0UA9F5UVsodeD2aNua0vWqzKhFknYoyo22VD7qKlqnW?=
 =?us-ascii?Q?/4ZVc9BOzIGxtdqxXdlbfF6SJ/8aJScpI4OUOK2+vv1ni6hg1V/7vbdAwBCj?=
 =?us-ascii?Q?yHxFIlymZU8svO15lt7ppjurmVfkZAGa6PnT4Pb/Zzmm+NLQ0WHdCMikblAZ?=
 =?us-ascii?Q?CvZ1mEmNIn/z5J+Tp5rzxMRaLHLUE5ADOQVofoejXGAWg3yEAYwm9dOc5uBC?=
 =?us-ascii?Q?zNcGH864Qhp91t9K2PSJU+ZmcvbdjA9R6cY9O7v6YpFSpk538ln8U+6uLkgR?=
 =?us-ascii?Q?Qu8ri0VE1h9TBpWuI1nxh7m1xNq+SwmfyVLPNLuoe5d7Du+fRCKS71hx+G5j?=
 =?us-ascii?Q?mLsgnHFlFuzz/+VX4hkbjefaSO77cf7zt0URt9Oo0ll7gHKBuIxICSg7YMVq?=
 =?us-ascii?Q?PLph5zR8d3K1/E1Tp6bu500a4fTm7NW00OgCAgbd8GeCSWoZSuIYuJU5jlYw?=
 =?us-ascii?Q?qKW9LOLzme3Sq63hYOSoBFVT9DTcGrnZKyQz8j2vK4G656ke+5fSMMLGQE0P?=
 =?us-ascii?Q?QZBt6BmJqNhMt+bmQq9NG0k63+XpkntyB+9ggN5O4AX8ruGqYCOS1Zb218rV?=
 =?us-ascii?Q?Z6+M4sCUlYhk48xNZ+0+bzULYdpjJm7ODpFf5VF9p9U9DH1hpX3CGbtGjHUQ?=
 =?us-ascii?Q?W6ITi6jsCak8TggYFUxbpnUvj1VWdCI2ItbXmDnegvQ5V0nyIG4iXPb4Le7d?=
 =?us-ascii?Q?Wze3lOofkwhJEBuQBO5S/ZM/1aAdnHO+7P1pD5GhF84IGb9BzDMq40KjA95J?=
 =?us-ascii?Q?LTyDzN542Zp+a606X2OC8nmnIPcdNW69/CX3SVUknUI5dFyM+dl4kw8NuLtP?=
 =?us-ascii?Q?Y8FiKW40FSuF2WJbICvZ2BWRp9BwfpP7NudQZpX2Jhqv/IrQXRJwCWY3iBgb?=
 =?us-ascii?Q?xdriwIWT8YPG3NTLgQUw6xh2jE7djjos8QbR/6ohhOJgcuZI3Xl3e1FtrjCp?=
 =?us-ascii?Q?/J5vxe2nXgtHUX4ldNIy7Ee6kU0XnzG7pojE/nSv3OXyBWa2dWjEF42TOKyO?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9oJBuJX74tpMRwnk+kxGc6+j48WMaD9yOF5+JZZtWs8ZSgK+eh3aPg8qm9gEnwtKhLxkflyDgr17zTRQq4f1WxdwEV/v37ohUznS9M97fVTSO0jLbF2Vh1Oiwj6pvA6ZFE+PyDYNBAoPJPooEV+f+Bls0MFsFryKy5G09dAlMAuJLX5lTXh119JH/v6TsS15zaRU5aDoQ3rjGVpsDbv4lKQiallNkIvXzueESUQbCpzEhVKZBbeBVEOhFMM+bfuk1eVz328DSlTOw0qW2a76gmNG4QqcYWnmyebhBUJvObgLZ6zEi742WfGDOH0NLumQJxvhK1bn5D7JKTv1cLado2fv3HDu6Iphf4wGQ2j2mIvuuoTPzZJlGqeEFzQ7TpMqabBzkD0WnJ1gBobA2r03i+Wy8bI8Sq/E9eF8xalCMkaGy0tDrWsCULlp3EXhiBrY9jeHZcKAzj2ct/vfOFzKh1G2SsslZzODYD75QbcdNDEh0WjblN2fTOwcqdQsoc70MM2ST67L+ZOzeUFgov9PJlFtI6/S354z/qvMmChknJjpalJCxFyrpY85B0RjskKS8IwoKe64zyJmNSsF6MVoTApuldqwWhr62vvH/rSPzvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5462de8-5abc-4814-b904-08dd53e30d04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 08:21:19.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF4VqxovcEjPwjiHwBN5jzRHfWt3mqyx7tLxdea12GpBFzo9pz5lUSthp+Xeqk8lD8VexbZAODOVncpkE3RJ9v1uRLNhdEAPMCHZi8YBh1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502230063
X-Proofpoint-ORIG-GUID: qu1MNcp-admR957CdOiJ-zD8I4vgoDv_
X-Proofpoint-GUID: qu1MNcp-admR957CdOiJ-zD8I4vgoDv_

On Sun, Feb 23, 2025 at 01:38:08PM +0530, Dev Jain wrote:
>
>
> On 09/01/25 3:53 am, Lorenzo Stoakes wrote:
> > Hi all,
> >
> > Since time immemorial the kernel has maintained two separate realms within
> > mm - that of file-backed mappings and that of anonymous mappings.
> >
> > Each of these require a reverse mapping from folio to VMA, utilising
> > interval trees from an intermediate object referenced by folio->mapping
> > back to the VMAs which map it.
> >
> > In the case of a file-backed mapping, this 'intermediate object' is the
> > shared page cache entry, of type struct address_space. It is non-CoW which
> > keep things simple(-ish) and the concept is straight-forward - both the
> > folio and the VMAs which map the page cache object reference it.
> >
> > In the case of anonymous memory, things are not quite as simple, as a
> > result of CoW. This is further complicated by forking and the very many
> > different combinations of CoW'd and non-CoW'd folios that can exist within
> > a mapping.
> >
> > This kind of mapping utilises struct anon_vma objects which as a result of
> > this complexity are pretty well entirely concerned with maintaining the
> > notion of an anon_vma object rather than describing the underlying memory
> > in any way.
> >
> > Of course we can enter further realms of insan^W^W^W^W^Wcomplexity by
> > maintaining a MAP_PRIVATE file-backed mapping where we can experience both
> > at once!
> >
> > The fact that we can have both CoW'd and non-CoW'd folios referencing a VMA
> > means that we require -yet another- type, a struct anon_vma_chain,
> > maintained on a linked list, to abstract the link between anon_vma objects
> > and VMAs, and to provide a means by which one can manage and traverse
> > anon_vma objects from the VMA as well as looking them up from the reverse
> > mapping.
> >
> > Maintaining all of this correctly is very fragile, error-prone and
> > confusing, not to mention the concerns around maintaining correct locking
> > semantics, correctly propagating anonymous VMA state on fork, and trying to
> > reuse state to avoid allocating unnecessary memory to maintain all of this
> > infrastructure.
> >
> > An additional consequence of maintaining these two realms is that that
> > which straddles them - shmem - becomes something of an enigma -
> > file-backed, but existing on the anonymous LRU list and requiring a lot of
> > very specific handling.
> >
> > It is obvious that there is some isomorphism between the representation of
> > file systems and anonymous memory, less the CoW handling. However there is
> > a concept which exists within file systems which can somewhat bridge the gap
> >   - reflinks.
> >
> > A future where we unify anonymous and file-backed memory mappings would be
> > one in which a reflinks were implemented at a general level rather than, as
> > they are now, implemented individually within file systems.
> >
> > I'd like to discuss how feasible doing so might be, whether this is a sane
> > line of thought at all, and how a roadmap for working towards the
> > elimination of anon_vma as it stands might look.
> >
> > As with my other proposal, I will gather more concrete information before
> > LSF to ensure the discussion is specific, and of course I would be
> > interested to discuss the topic in this thread also!
> >
> > Thanks!
> >
>
> Thanks for this, as a beginner I have tried understanding the rmap code a
> million times, after forgetting it a million times, thanks to the sheer
> complexity of the anon_vma and anon_vma_chain. Whenever I read it again, the
> first thought is "surely there has to be some better way, someone must
> figure it out" :)
>

No problem, this is something I am very interested in putting time into,
and _will_ be at least -attempting- patches for (I have ideas that likely
will land _before_ LSF).

Note the follow up mail - I am providing short, medium + long term
approaches, no longer JUST focusing on the 'how to remove' bit.

I'd be remiss given what you've said if I didn't mention that my book
covers this stuff in a great amount of detail, including anon_vma in a lot
of detail (I steal some diagrams from it for the LSF slides :) and that you
can pre-order and read full draft now... https://linuxmemory.org/ ;)

But also in the slides I have drafted start by (as quickly as I can so it
can be a good discussion) go over how file-backed rmap compares to
anon_vma, the complexities, why and the pitfalls.

This is to provide a basis for the 'So what?' portion as is - what can we
do, why, how.

Point is I'm attacking this one way or another whether I host this topic or
not, as I feel as you (and I am sure many others) do - can't we do better?
So it seems a nice courtesy and great opportunity for discussion to speak
about it in person.

I know for one in VMA merging we almost certainly can. And since I
literally wrote all of that code (latest iteration anyway) that's very much
in my wheelhouse.

Cheers, Lorenzo

