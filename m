Return-Path: <linux-fsdevel+bounces-23589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AB92EE40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 20:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC151F21AD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E17176AD6;
	Thu, 11 Jul 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LBDFmy3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zwJppPjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831E176220;
	Thu, 11 Jul 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720853; cv=fail; b=LdskAaaVznnSLjs+w2xFTI8eNd3wOwxoc0R8Fn35ZTAa212jKtCIx5FZmCaJeZ7IDZucnf8ORyleKFkYn67zDw3y8OSWvM5g1soPqhgUKSVYbHXYuWhIAszNPAOLshbIYnb9R35xm8SnlbhmXqeHdW64EhiHaJwxXaqnd4g5b24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720853; c=relaxed/simple;
	bh=Uya1e3Mpvc+1CzKyyMo8MSkoql4G8PVUy4chQmLlRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgJ23XRj+t1MlaBM1wEDhDUdkKTdXC1uF/7Fcw12nei7nfKO2TmwSwg61DckNIDsBd7xWy9wGQxP2uNimDELOZuBW7NfoTe5u6PoLDGMljAxLr4gxTn/I+9SyCuweKvP0NqTEklw5uXzWGCslHyHP7mqZvpufT02HBG7S/AxeFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LBDFmy3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zwJppPjx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBXg0028463;
	Thu, 11 Jul 2024 18:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tuaU3PD1kwvr9Wv
	dfPLyohRkpyb4UTOxT2X1pOdT+as=; b=LBDFmy3Ab/3kSZUlFAuQ2SP+xQJ53d0
	2aFOtvZRItOiC+JJ6YYRCXp2xRAHIXfvmkKDxsbOveKDl5lfoGMfgHrRaVoY043V
	YiUFxlanYd2nagCiW0Db5dZ88J1l3yEi+DPe9pa+iKhzCAXIbIOdH474AwgRNje0
	N7ErU32Wew0BNh7jxPY8bJxmdVCS2kLKLTLxQs6h2ZcQh/AnZskI2qfZ90Mk55lY
	a4oetl+CdM9pdoGxzPuYYBmgiNxaql8ImoZf3hdc/b2g3L0xctuvp+0c4eXoSx0d
	MKTSTtvToUqkP4xNUOWb75jpXQZoZo9766nnSZkmAm1wIRrfU5RLpRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcj4yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:00:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BHxOHL008763;
	Thu, 11 Jul 2024 18:00:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4x9q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+ATgMsxuvKzqQP+XTBhu/ry0Uj/TctNN/L0q6PAdFs6a5nwkLKHWOanP6/Q5YnWa0Zgemhdq5kO+sJjEs3AJM7Lwj/YS1kFi4pLbMLv3Rp8JlyjCg5awIz9HCljh5Z10W2oLpZMGzVmXfFTNy42vXMU+Ez0FXvM7oHq+Feg5LxzW1Eaugsp33lUprr11Q8X/t54AA0qf2CqCjKLBMdTucYw5jLXNDHRpYPRlWDyCLfjPBA5ii+1sNLThu8Jr+Fj3V7UP0aKSD0Fn52zpGlESfFhdPcif0MFNabXWeE0CuB0pmQePYZxcXUs2gHiNsNkSupzgOkO5p7+0W/7uiweqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuaU3PD1kwvr9WvdfPLyohRkpyb4UTOxT2X1pOdT+as=;
 b=aHMNhWax/fGyYkNIx1gWwa/VCxxgjKDjr7CpEtuWX68dH4+0CgfsEFcUUbJNb3m/y14ABBys9EkgE74INcxJOwh/wfakOKnyzDTSmu3rr7PHszp9sc6b6TtNqJFgVcAKNJovlgfT67c3UYbpoTE4l4DsfPoSR03Zl29zd0S0CJxI4/Ubp0UliXWzqipwldvantlrkigv2VcAROGdAmHSyxRId0XMwAUVmwC0/olbVLpT1FiGAxoEkzS18rkb3r/2ETKRRLuIe3EJPELgz3skyN88dPYNJwbp9VAwibQrcRT85UkBlHkzg/MPRiyD05zF6fV1/3ynb438eesV69LiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuaU3PD1kwvr9WvdfPLyohRkpyb4UTOxT2X1pOdT+as=;
 b=zwJppPjxgg+e+Z62nRaleiK8QANI0LF8FkXffgh2bpDw+MLCorcrBfYS7mwrkHaS/ZqlN/SKBQX3Kf6PvJkBoG12nVhtgcGbOeCNs/qtrIyBm5rQOWXP1nfI0XvNp0nV9oi0TA/6cTHdbh7U+QRx1O+C3AtvhkgDR1HpEPPTmPI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6025.namprd10.prod.outlook.com (2603:10b6:208:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 18:00:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:00:18 +0000
Date: Thu, 11 Jul 2024 14:00:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 0/7] Make core VMA operations internal and testable
Message-ID: <3sdist4b5ojz2iyatqgtngilrkudb63i7b6kp3aeeufl3vrnt6@p4icz5igbsix>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <8a2e590e-ff4c-4906-b229-269cd7c99948@lucifer.local>
 <20240710195408.c14d80b73e58af6b73be6376@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710195408.c14d80b73e58af6b73be6376@linux-foundation.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0ac3cf-7193-4d75-e176-08dca1d35319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yoa3oLvVrxf+0ww1Tz5ClHVInJijon1LkWpNHA9L6wLgLiY9xjE3vN8bbAyU?=
 =?us-ascii?Q?g+xqbvvlvR4WXPpyeDqNcUiqC4GDvdGmDZ+ITQPkwhV0K0RaclESYcNYVdzC?=
 =?us-ascii?Q?LltkLGBOrHz4biR5VMtIjfaKk8suwdNKmyj8whQSCFGpGndvLw8zqOTo1O6x?=
 =?us-ascii?Q?azNOckl7RBo6eEHHB++blKZXIVw8ZE5yrW1oGmDnSQZkscFOlC2zK8B7lz/D?=
 =?us-ascii?Q?pLDSzTGGdz+T4D4eKOXAKgVLbJ4+EINEukarEvZ2jdIwGwLHwcQp/gVYb877?=
 =?us-ascii?Q?yzB4LJ2qHmr07gfsE4HcF/xbaWCjJkfd9wrbliHeyaRqwetPe1egBtkJLdMo?=
 =?us-ascii?Q?k4Lz8rdJoRy2ElrHfUUN3+P5aNF1tnSZiWYBmdFv7i3y/YvXv9eMSVST4yzL?=
 =?us-ascii?Q?fOqAg1p/5eIA1BHSKcQS8h21q+UWIBc5eMKbFYgnK2CXoId8gtBpxk7yt8e6?=
 =?us-ascii?Q?rQPOt2+raQ4bAi4I5vP23efMHU9V1+oi0/5NFnKJCr9Pi9wGlRjUsqkcrKrR?=
 =?us-ascii?Q?5hl5hgSeEVghavT8PISW3ImWS8qIiKM5jZlXu4l3dKEAA9Y/rcKHfhY18Z4H?=
 =?us-ascii?Q?jpKpr0Y3o8rC2mTDbM6jYlsOjJlcd5rN3RekP4WgFxLIuv8OMMzAc5LblGRF?=
 =?us-ascii?Q?49mke5ckk6YVku0SHYKomAynemwOWTvNEOBXDL7IiYjn/3tCipKEjBg9pNxG?=
 =?us-ascii?Q?maPJ1vMAMEziqNHMdA8mUYJYJxTgn57RRYX71rZMuWpeQqKWMHDxIA0879Dk?=
 =?us-ascii?Q?s+cItItAK7yZ8xLCB0FkbbMgQV31t9oaSmiyAEapvJ7YlPwgSWJywL8M8cyM?=
 =?us-ascii?Q?tw6bTsM3Zo2VB0nezk+Stlls+EzzY6LFBmEJV7H+5aUh+8vxYvsbAH2ySvbz?=
 =?us-ascii?Q?WqZz7TkDQ4SfFpQikK4LbqAE6WwsfWoZmlNzEhlUImWSd8nIzf0NY2wBigeR?=
 =?us-ascii?Q?3cAtbi9tGHDxZbM9SMwzBRxVQMxdCRQbanShsz1mUPq8Q7tfZuhd/y7qGyi5?=
 =?us-ascii?Q?qamN2qgtZ3ElwgBjjm0duxKCcVf5s3ThRhagWoEMDY+6UrOfHidYzE1ROLrq?=
 =?us-ascii?Q?SOFFkqLYcz4CthHKvImT8ZAKA4kGA819+/DbLZ40Z7Kgm830PJ6K3VdRirTp?=
 =?us-ascii?Q?5D+B6Soav9u3ugVpo71cZ/D1ppaABDNy2JwQ9v+8mhRPgXU40FG1ihJ0kVk1?=
 =?us-ascii?Q?Wd3SAfvSYorXllZ66gEwzQt8jiGcI5gjhG2vXtAQROzNISjazFowdSH8ebF5?=
 =?us-ascii?Q?RS8qnq8ViOX1woNa3ywlnq9Ac9Aw6SHZqmPq0WEdjohTihgRTmmLscUuOTtR?=
 =?us-ascii?Q?0z2JEnxXfZo6AWHUCSsJIC+1vZsuWy+cENXLTJMJHZrpUA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JiYGodJ/1f2NW072oYeYu3iHryl66r4Tft0U+xSzssPceFJFgWs2clTMLZqw?=
 =?us-ascii?Q?VcUAAVGXNLDGSMU3L0L6TeL0iPcFhBVELNsg+o7zUpoaQ25FK1aLwhYeE2ZM?=
 =?us-ascii?Q?AZx8iDytiLv0ynoM+FLK8NB9voNGx+0Qoak0daP0gI27b68NkboeYebettZd?=
 =?us-ascii?Q?6CdhIs5FxNWIEBEruaVbuP6enjmnLJD8b6WER8JG2W72gabE3v5p9CEI4ghy?=
 =?us-ascii?Q?XjGLYTrrZ9xgkcm4aJNdOVMtIEBdVc89cPV/RVsDQt8AQtFLQiJr+OmSqszy?=
 =?us-ascii?Q?9Wvu2QCeRZOK7/yrdW+1Ffag1mXZSuY2QDyCHLT2RVtS2N6NLEZFOhRF+rkE?=
 =?us-ascii?Q?X/5MTSG1tHxahnFf67KXch0XVqyzEM62jRYXTeuw0tR4e5pixgeKqmDqQPiF?=
 =?us-ascii?Q?6yvb3081kvBDa/f3wH0lOyztet2jrKc3ZN2eHB8P8QzXVgXG/WiPLtyJ74WH?=
 =?us-ascii?Q?aWoA7RdMNserYTsmZCn41SSme0s2qh+HDAqb8T0xvMumO5GXtMd8XlMDe7dY?=
 =?us-ascii?Q?EtQPuPMQuWWvhZ7yTUg/3HIWG8k30UYTqjKd471hMJdXPz6YlRS5wInfJq4B?=
 =?us-ascii?Q?gOwAE+THo0IPyTSXoNhSzmmoQWVQ3JTfu/Nez6IlRrYkUVNqTlU8yxUj+83u?=
 =?us-ascii?Q?eB9Ml4+doZJeGXBTSpcvLBbPDq7l75u24IyxMxFqXonvaAbyNiC0cSsWsX83?=
 =?us-ascii?Q?h9f68iKvSvD11eL1BNtPqvuwCnYg824KT6guIKnr+HFPYquvkpuTQlJg/53g?=
 =?us-ascii?Q?N0ScNhbKbYwj14/+OwJYI0J27CLOV+7g90JtfB1kYmwwU+13+whH+qPCOCxx?=
 =?us-ascii?Q?xmoqdkdO3yTIxwFK/Kco7X1sfKKlm1bvnorsbFJjUMQXXxvxdzGmgDRbindQ?=
 =?us-ascii?Q?24Oc9lt3W2S++9Sdt0EJjoa447lPii2cWN2Gi6q9g7cm68mzM4AElRCcLe0I?=
 =?us-ascii?Q?ph+txgGynci86ECidmKIWyHQ7KrxgNi3VMk1EpQ3amA2ako/krCzLjK+Ufq+?=
 =?us-ascii?Q?5O0ug0Gz+sJlgDHk6zhwzC259TzPd27mOB9QVmI27X8gxSX4rDQp6EM6fqsK?=
 =?us-ascii?Q?jg6e97UdmWMR2RMA2ritH8LK+b6EGEE/ObB0imT1SytcAtoS70Xtl58xftXk?=
 =?us-ascii?Q?cJEGb9F/eFQo+WlRxLw/IXo34uAYQ5uiZ6EYKhmXVGuSEfbm7glvxm5Z0KNH?=
 =?us-ascii?Q?UWHZgunO4rYAp3SuZC4F+npqxILNxe+h/D9k6ZPpHZdgGlJI5VCAkzdiO/yX?=
 =?us-ascii?Q?KMeFJCEfPM/7yyJuzH/qaB9YJvF51h2C5V63DcIOcnp2C5CyF1vVP8AI8oIN?=
 =?us-ascii?Q?UUrIJxfoK3nlqkjizeibNwfektf+wNdV5jLkcOh7wFh5NZaDenzbhswvqWP5?=
 =?us-ascii?Q?HRmUnvDNclulcsfel0TBY/hoz0Nw+mR3vgFaLCw/8ketu2nDBFlbNczJjCE0?=
 =?us-ascii?Q?4iMt3QIK0fyfratqjTFQjhGYNEi471PsGjB+s/VTCxr9FNcmUm+DmPmbOpa7?=
 =?us-ascii?Q?plv3UpW56OIMwYroBVixWZz+Vog95zcN+4wEAR5k2LEGfAZ/4OvIaOyenM6e?=
 =?us-ascii?Q?5C//CYuY+qewDX6aMslYWTuk1+AYOIrP8z69eJlCZsVL+xtU7RS0UN3Q3Lxr?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WBenLmpXCmjWNXH43uiE4kB5jwDPZ43grYtxh8DaNqu6LdrlXI3GGlwGdqd4yi9tC29ZDqhmDjPHLCkIOyFQyWTbC19OKb71bl0K3GGLsau7f9Ww8JbVVAKC3MT0uQETA34qfvIJVMiMkyaLCcnuPvjaUfikm3lqCr3dGMUDBOOMeZt3E4hoLIFwE+malNZe7FVUiOc8O+bQ+zl1FmhifoSE68uNEcjwa48mo/Pto0vy9uyU8+4/JCl+Z6yqJtj+Aj7Nyni/4DuNg/Jg1/zyTaweIhoRf4PmoLpHDQuyDv0wK3N1WCCZVXoLAMWavF7sHiHln+xZLWV5cCY/9Mj2MJzIrBOx+iRN6pDkCfHsMPM0D6SqJ56IFiNsEYk8muZY3Xj2wxVZU6k+MqYGUeoJYHJPmOv0WlyMakd7irxBir/JH2xwf0YS2MHzdGju66kGWQsRr6g8EQWzypL37eNFyBtEy6lPUGO0SY8sP+kJWytmzPsydG7j4APzCw/Mnvw4LmJtcriGhLQJxGCMo0fUxtW0PPl2T3D/SlZ/oN3kdU3rdeooWbik74W6LAa/vC2A3VDZzWY/cK8RrlS3H6mcRC63d3+oYxLBapE3GkRo644=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0ac3cf-7193-4d75-e176-08dca1d35319
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:00:18.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtAa6qVw+VR9uRiv8EQOb1zqX799IQBFc3bYgWQFIa7tS4NVXITxlWYRkh4ZvAmGm4gzbN/zMhQ5jsCOjMlNow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110125
X-Proofpoint-ORIG-GUID: ZkGC1DaCjTpXAbDpRlOewqZLzjBAZBUR
X-Proofpoint-GUID: ZkGC1DaCjTpXAbDpRlOewqZLzjBAZBUR

* Andrew Morton <akpm@linux-foundation.org> [240710 22:54]:
> On Wed, 10 Jul 2024 20:32:05 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> 
> > On Thu, Jul 04, 2024 at 08:27:55PM GMT, Lorenzo Stoakes wrote:
> > > There are a number of "core" VMA manipulation functions implemented in
> > > mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
> > > expanding and shrinking, which logically don't belong there.
> > [snip]
> > 
> > Hi Andrew,
> > 
> > Wondering if we're good to look at this going to mm-unstable? As this has
> > had time to settle, and received R-b tags from Liam and Vlasta.
> > 
> > It'd be good to get it in, as it's kind of inviting merge conflicts
> > otherwise and be good to get some certainty as to ordering for instance
> > vs. Liam's upcoming MAP_FIXED series.
> > 
> > Also I have some further work I'd like to build on this :>)
> 
> It's really big and it's quite new and it's really late.  I think it best to await the
> next -rc cycle, see how much grief it all causes.

Yes, this patch set is huge.

It is, however, extremely necessary to get to the point where we can
test things better than full system tests (and then wait for a distro to
rebuild all their rpms and find a missed issue).  I know a lot of people
would rather see everything in a kunit test, but the reality is that, at
this level in the kernel, we cannot test as well as we can with the
userspace approach.

With the scope of the change, it will be a lot of work to develop in
parallel and rebase on top of the moving of this code.  I'm wondering if
you can provide some more information on your plan?  Will this be the
first series in your mm-unstable branch after the release? iow, should I
be developing on top of the code moving around for my future work?  I am
happy enough to rebase my in-flight MAP_FIXED patches on top of this set
if that helps things along.

Thanks,
Liam

