Return-Path: <linux-fsdevel+bounces-1153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E17D6759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA071C20E15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95BD273FF;
	Wed, 25 Oct 2023 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="CCqEVald";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="HujE1mML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27E8480;
	Wed, 25 Oct 2023 09:44:25 +0000 (UTC)
Received: from mail-edgeF24.fraunhofer.de (mail-edgef24.fraunhofer.de [IPv6:2a03:db80:3004:d210::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1E19F;
	Wed, 25 Oct 2023 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227061; x=1729763061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xfHIWfu+FOq/jbmo/K/PtYK8ttjna13orZaG8aVLYp8=;
  b=CCqEVald44HACVKh7rXm6tuLjzdB1LZNL1E0JV3lXmkaW2Cql7OIM63T
   pXZcxoz5pFWC4Mv12nDjvA55aKfH+ImvpCtwNdySrmCA5vIXqy2axSPaC
   UceL301tr6XIWyfUv0CQb7dPN+ewnxet8kJCvYK9XjFkybf88aOl6lkyH
   Xc8yGci2V1DUHPCnJ8NcKI7dS3CUf+ohmF0DI1LlUOgoOzBKja/JGUTu7
   7YMqVpG/mBQ8hrPHVVdwTeL1bJ5LgHDFxDed3cwR+/SaO6u95is5ArH9E
   cpYDbgVBhJ+/CEsxZ7Vvod28a8J8vBnPS2VUklRLjA4NaPIAZeMqt5VQ9
   g==;
X-CSE-ConnectionGUID: THgPYn6KQriXTyw5tn6oBg==
X-CSE-MsgGUID: wfq6KoI1Q/SLsQsLFZUN2g==
Authentication-Results: mail-edgeF24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/xwBYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4gleEU4gdiUGYJoQEKoEsgSUDVg8BAQEBAQEBAQEHAQFEBAEBAwSEfwKHG?=
 =?us-ascii?q?ic0CQ4BAgEDAQEBAQMCAwEBAQEBAQECAQEGAQEBAQEBBgYCgRmFLzkNhACBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CNVQCAQMjBAsBDQEBNwEPJQImAgIyJQYBDQWCfoIrA?=
 =?us-ascii?q?zGyGH8zgQGCCQEBBrAfGIEggR4JCQGBEC4Bg1uELgGENIEdhDWCT4FKgQaCL?=
 =?us-ascii?q?YRYg0aCaIN1hTwHMoIigy8phASHeoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGU?=
 =?us-ascii?q?QQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBE?=
 =?us-ascii?q?W4FGhUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDBIE2B?=
 =?us-ascii?q?Q0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxocCTwPDB8CGx4NMgMJA?=
 =?us-ascii?q?wcFLB1AAwsYDUgRLDUGDhtEAXMHnU2CbQE8LSWBbg5DlkYBrnkHgjGBXqEJG?=
 =?us-ascii?q?gQvlyuSTy6HRpBIIKgIAgQCBAUCDgiBY4IWMz6DNlIZD44gOINAj3t0AjkCB?=
 =?us-ascii?q?wEKAQEDCYI5iRIBAQ?=
IronPort-PHdr: A9a23:ViDUjRTNaSgIxZFKTT9G4EQdHNpsovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C6vU6THFhLEi2Q6feo71fbQdVz/4/
 rt3akW4qhg/Zi8czUyQoMgsk7Jdqjf09Hkdi4SBQJyXGaN7W4fDdM8FGzR8dJpNWyJBRYXsX
 a0CIPI7FMRnqNnegmITtTa1CCCVCcPiwCZi3kW11ogn7bpwNV7s5VIRJ/4qnWr6h8zILKUXc
 uaIkKjBlD/bdvJ0iQzXxarneE8Hi6GgZ/FRX9Tuk3kiKT/mgguqhYPfYjPEzflVnEqp3tt8b
 dKtmT8IqSpYmRKt3v18i7j0nd062Eza/ngoy48lfsOgaxFXQfP0RcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mKf4eFzEi/EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
X-Talos-CUID: 9a23:JHfu2G9ZvDlDvEV06OyVv3I0FfgUdCP+9W3RE3OpFjt1TuOSY1DFrQ==
X-Talos-MUID: 9a23:zWAcjgVqQ60yIt3q/CDinW9BM+Yx2uOVLFs0irEoifSibyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="62757492"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeF24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:10 +0200
IronPort-SDR: 6538e32e_u995T+0f3oI3d8Xb2kCivg0XfYFggWJCbsif8dTsb2Rtm+Z
 gO48y34Lg4sdYqOE2vKa1KF9YJV1dCJIWD7GB4w==
X-IPAS-Result: =?us-ascii?q?A0A8AAC94Thl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBFgcBAQsBgWZSB4FLgQWEUoNNAQGETl+GQYIhOwGXaoQugSyBJQNWDwEDA?=
 =?us-ascii?q?QEBAQEHAQFEBAEBhQYChxcCJzQJDgECAQECAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQEGBIEKE4VoDYZNAgEDEhEECwENAQEUIwEPJQImAgIyBx4GAQ0FIoJcg?=
 =?us-ascii?q?isDMQIBAaUwAYFAAosifzOBAYIJAQEGBASwFxiBIIEeCQkBgRAuAYNbhC4Bh?=
 =?us-ascii?q?DSBHYQ1gk+BSoEGgi2IHoJog3WFPAcygiKDLymEBId6gQFHWhYbAwcDWSoQK?=
 =?us-ascii?q?wcELSIGCRYtJQZRBBcWJAkTEj4EgWeBUQqBAz8PDhGCQiICBzY2GUuCWwkVD?=
 =?us-ascii?q?DUESXYQKgQUF4ERbgUaFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGS?=
 =?us-ascii?q?gsDAhoFAwMEgTYFDR4CEC0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA2wfFgQcC?=
 =?us-ascii?q?TwPDB8CGx4NMgMJAwcFLB1AAwsYDUgRLDUGDhtEAXMHnU2CbQE8LSWBbg5Dl?=
 =?us-ascii?q?kYBrnkHgjGBXqEJGgQvlyuSTy6HRpBIIKgIAgQCBAUCDgEBBoFjPIFZMz6DN?=
 =?us-ascii?q?k8DGQ+OIDiDQI97QTMCOQIHAQoBAQMJgjmJEQEB?=
IronPort-PHdr: A9a23:lvyQWB/TwSp4Kv9uWWy9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxyZtWBL63kqlX7D09Wj5hu5U1iLALNHqb+pkewuav
 rZOdTKvoiNbKC4/+kSC2akSxKgOgA+jikV65qrKaZ2KaqRDVP/Bcd0aAmwRbOBceDR7K6GDa
 NssKtMcJctToqDEqnsDpwKUXTPvD8by9GEZoiDc5PML68gFPB/o9xUdB9ALk3Lp8NT8ba0KS
 OGXnJLi4BfsZaxw82fR0svpXA4e+8GBY45TfZTr5UYVSgOUlUjIhq7XDgKJ7tQPoTm07cFJb
 sitk1R3qjBMuWeA1NsygdSYjYsFkU7c1npV4KtlcI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0P1J0E7kSPLfKdepWO4hXtWfzXLTorzH5mebfqnx+p6gDg0ezzUMCozUxH5
 jRIiNjCt30BllTT58GLR+E7/xKJ1yyGygbT7e9JOwYzk6/aIIQm2bk+itwYtkGrIw==
IronPort-Data: A9a23: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
 VFAO0QDOXk=
IronPort-HdrOrdr: A9a23:4sS34Kj1sgRPnOtVEqjzEqcxHnBQXrUji2hC6mlwRA09TyX4ra
 2TdZsgtSMc5Ax6ZJhfo7G90cC7KBu2yXcf2+Us1NmZMzUOwFHHEL1f
X-Talos-CUID: =?us-ascii?q?9a23=3AA78ZVGu0APgybVnfmAGCzAa+6It/T338w1XfGHW?=
 =?us-ascii?q?bNm83deCQUkGw/5x7xp8=3D?=
X-Talos-MUID: 9a23:iJDVyAR7qWe9CuvORXS1vQo+MZ5Y6p6NM0stjc44uZDeah1/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="135077960"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:09 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:08 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzTY+qYKCrJ1Du9XpxOLo5BVp3unINjF6DIACG4E2bhWNXOhWVNKPX3JG92Er2QUIhgMhEzD8r+ketflkrYrGRc/E/vHu8wNRgCNZ35HmAwMeCJNCPEJyLKx+CEeiwFt3cRp3/Goqf4B4LkB8Q956D2tS7+pYRIGsgDKI26aOpe3l2n5zzlXEE0KkEBLBBSTLl94tSnMrDbNJCr5fln2piCo5fNicxNwk0zN+v+Y0h4Zk8zGfBouiOUxbZ34mA/+Z9rQzrCrrAygicDdg0+fvDALWlyLeROVwmSlS9nZsEf9CLG9yEzQJYQnHhslf5NIvE5GNZs1XOA9zkeeCZljFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM3rWZ37iOm/+kXlAfc2yttJ28JWP9yMUE/Bl4wxnbM=;
 b=K1NQ63z07pLciFXWK0lHVbwPVoNSCroBLFIyBFn5GU1y2Qix1tlkcIaN84edP4rNTtNxOoTP63P+IdcKGIchmmj5k8i5IbFeUz1lkil3q0mZo1dUWNB0ij5YJjMFqDeLxRNea0ON3RkO0Fff/urLdaKym5oeOiElicJkLp4OEplBIAj+jlO/OihEZlUjgWBi5o5f4NUoaaLJeuokHRhw/1l+ofblssEDsNqcE0fX3enNXrxD4yBOQRHhfCAkfgg62FRvKMiUKBXZIfbtDQD+6ui3Rbko6hYt3ph3e+gkfksFXVLwrR3ywq0/u+j6kq4KCR2jlHzLuL0AemQHLcK16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM3rWZ37iOm/+kXlAfc2yttJ28JWP9yMUE/Bl4wxnbM=;
 b=HujE1mMLvatw66UB4tdfh/n8ZNeGpRAJWo8KMQupEceAQeHebqB0R+cMuV69L7BQ6YPDLEvFCqUpjmKnU4ia1bpqiJ8SBEJGb7NB8DR+IFvW2XeVTKd6RDgR5h9su0GJZYYtPXjz9GjCASBjpR8iYUs7Gztvc59cax3vpK7DHE8=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:07 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:07 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner
	<brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
	<paul@paul-moore.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
	<amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [RESEND RFC PATCH v2 13/14] bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
Date: Wed, 25 Oct 2023 11:42:23 +0200
Message-Id: <20231025094224.72858-14-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BE0P281MB0116:EE_
X-MS-Office365-Filtering-Correlation-Id: e03c1c06-6d09-4730-cc83-08dbd53ecad0
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZ2y04VC63LLTwCwdU8DZ47eWNOLifKQxnujmUKHc+nJn4BDMSR2gCRUvB3j9t8U4LYIhr0dtpk8hmSqo24+AqqIG1rso3y7QkkQLBqdCjvn3AlNIp9owNFSHCofd3zX8Yq9TuBzH2YmFIRxePyPRZLJbylN7zx/7pVtWPd2MZwC3eLSzYRPxHNI8m4wq9bn9txWRb8+5tYGVLMe7MROSPYw8GDTvF0FVurURdZ2TLEUmBnXkITPspU5/X9n7sZZsTdQvJ01SwqrLG2wpYSag15/APv/ZrqH3/zTS6t2AGLaR+PkG++fP0ZNfDdo3LF6J413Eu8eTUXIIc1TNFj3MjaF1L2vqkubZSyG+OZ3aWisvhz+Io77YNByT0pNBw6xw5MLpK9wqby2JKmtWTTi++t8LuPjnUj9Qmj9e9GQwNdSbydkDfbioIzq2mso2Ie7bsS2VloFLl94/KJEirPIhVSFHNVF44ez0rnVvZKlR7SAefv3SUC/W3eOZy4Sz9PVw0PskP51st1/TqdQisb0Mn0e91xFAjGzzpZCYBp4qYwsBgZFSwISz7P0DLXKqFEhjkHQSZBlqmHHWbM+RaI+dcLzRxNoeknbxkh1mmBJiQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(52116002)(6506007)(2616005)(6512007)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekMzd1Jadk9vWWs0Wll3QnRjUXJ4eWVQU0hXd24rbURId3hrKzNIbzVVckxO?=
 =?utf-8?B?Zmp3VmRZYzFldW9kZGdpR1NZTVFIYy9MTEMrSXgyeWcxb2FnZHRtdVhEVUFZ?=
 =?utf-8?B?R3Z4NFk3SmFDcmdQOHBGY0hEQ1UwOTZnbDZ3MWxRdklkdnJCTVVuaXF5M010?=
 =?utf-8?B?MXA1RnhKeGxYMXBLYmFYMThKWENnUHhnYU5EV0lKSTc3L1RKODkxY0hnSXYy?=
 =?utf-8?B?WGFNMytFRzMvS09jUTA2WXhpM1JXUUIxUVFGYzRLNlBOcW1YcXlQUkJ3MUxk?=
 =?utf-8?B?MEh0UFNCQjE1aCs4bXlReGRYSWQ3dXhZc29yZWNyelUxMVhkdUs4Wm1uc0xF?=
 =?utf-8?B?Q3RWcmMvbTA3Rm8vRlY1d3hBbVdIUnNxOFZERzVac3d4azlmeTN3UEd1dUZQ?=
 =?utf-8?B?ZFpRcEdWNUgxeUo4R3Axa0VTUnNrb0FzR3ltY2hDV1RuRDRrdHQrSTBuTXhi?=
 =?utf-8?B?MXhuV2loU0hGVzlZZjliM3djdTNnUTZQMGtnUmJTNStnSHA4RWFJazJqZWts?=
 =?utf-8?B?bkNIbjdlVm8zZzkxc1pDejY3RzZxSzlTNG5qak1JTEVtbG56dGdzdW1ZMlZ1?=
 =?utf-8?B?b3RFY29FU2pldVJ1UXVsdzdwYWFMZGRMNFNJeXNCMFVLdzhaUFg1bTQ3Nllx?=
 =?utf-8?B?bUQ4bkl1R0pZbXVlWEZiRmtBSXMxK1VKZ0ZIZjNNakJvSGZoeTg0MnVhNmhV?=
 =?utf-8?B?SWJqMnZGTDBtRGwyblRrdXlKWm1KbTNBR0RlUnp2Vjd3REN1cG9YTUlMdEZI?=
 =?utf-8?B?em9QRzNWWVRRdVdYQWlMc0VpNWlJWThUckFCcHFPd250eWtQUUlrWEV0RHBK?=
 =?utf-8?B?L3hYK3h4M05oYTBOM21HTTQ2amRZTStoWEE0ek1EYy9GK3RVaU9wTWtJMHAz?=
 =?utf-8?B?cUxISE9mR3ROZkZNaSsxVkptcVRqWTdDdUczRWZyc05HUm5mZ3NLQzlRRE0x?=
 =?utf-8?B?MFZpQjNYSVJTbDlvbGNmL1Vmck9odnJmcWYxdnNrbXBCcVl1OWo1STJnMWI1?=
 =?utf-8?B?VEZNYlJCUzZyQ1VrWnhremtqU2oxLzc1b1VVbXUzVVcyRHlaekZqRThibkV2?=
 =?utf-8?B?Wnd3dDVTTHNZMy9TWTByZ0VaSFhTaGQvbERYanQzL0YxTWJlQVRhYktzWlJW?=
 =?utf-8?B?cFRNemxMNWVyaFFXN0lvdU5uNGU0NGtXeHpGL08vSzlKM0hHWVhJVEZ6KzQy?=
 =?utf-8?B?RWJoWGc5Q1dxb1htRkpHTWJjeFFKTlJLSk9WWXFYbGlMam9xUnU0OW42c1hZ?=
 =?utf-8?B?dER3b3JvejVMYjVtRERERUFTWGErNjVLcVRCWVphMlZoUWp2MFQyZU9lWXBS?=
 =?utf-8?B?RWRtVXhZVzlNbVJkdjZ4Nlo2aWhNRXU1S3BNT3pnWmgyQk5mSmpzSEJJUDBN?=
 =?utf-8?B?eW9SdEVGdDlReWUvaGlvL2ZTVEQyTVI2OHhlLzFFZGtoZXVOQ1h4VlRldFhM?=
 =?utf-8?B?RFBjUFNKaWJuMkNIdkMwKzBUR2ZZamVuelAybnV5cm85cU0rZDIzZEdybUtY?=
 =?utf-8?B?S2dYRVZRNDI4b016cGNuSGc0NnlUYmJMVVlSWkhGL0NSVDlBWFBPWDBtRWRy?=
 =?utf-8?B?QlpsZ2lHaE45NjU3dnFob21PWldRM2pmdXZEUmVmNkl1UGF4TXpHbHhLRG1H?=
 =?utf-8?B?bW5YU01XNG9pUjkxUnJUYzNiejJCTWtCcDV5L3RqY08rMVFLTldvR2FwbW40?=
 =?utf-8?B?ajRNSEFoM3JnT2hVb01YUTRZSGxwaVRCSjErSEtIR1NvQmUyTjZ6R2sxT3VQ?=
 =?utf-8?B?ejhFL09jOUtMakR3bEk0YUp6eWZhWXExdUh6aDZNeVJqWTlPVlV4eFA2YlR4?=
 =?utf-8?B?OG5TQ0JJNHR5dnNNMHRMSEc1cUtxZlliZTV4ZzdDMkp1MWsyMGEwcUwyNEVx?=
 =?utf-8?B?UnBFVjJGU1dkNis1ZjJMQ1FHaCtqSWRYZndaaUd2bVhuTVF3Y1g0T29MbnB6?=
 =?utf-8?B?RFpuRDZTRWVISkJJU2c4UnRHY3NJVGlFeERLMC9GSGV0RWxMQTZCSzlja1Nq?=
 =?utf-8?B?eG5PYjgxYkN4V3c5eUZ4MmJGL1pEN1FkNXp6Q0tQMEdwY3BaOVArVjFNK2F2?=
 =?utf-8?B?S3Zwb2hVZG9qV09mdEJ6Wkl3R0ZrWElidUh5cnduUk9ucUlhVHp0ejBxSjFF?=
 =?utf-8?B?Rm85SDZGcFYyZTNyUzJOOU5UMUFxOHVrR09hZ2ZqYlM0Szd3eEJwZndHWGpU?=
 =?utf-8?B?K0hialFrc1RXdkxmN1l5dHEvQ1I2Z0Vnek54VXZhNDRkdXo4WG1xSHlNVUVt?=
 =?utf-8?Q?2Q7UOgspyo2wOslYsSI2q35G+iUT3GoJy4RXsZleWc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e03c1c06-6d09-4730-cc83-08dbd53ecad0
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:07.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGBrTQLBBxYvBDOPV23YGMx640pRU+21xc5d9X0e0w9rvkPgrR8oe/7vdwP+S7je6G2gTimxcZgaZaMOJvAGVoWJasj3f40XqUdM3aZTfycXfQdazJYqOPQ2sFeIZQ7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

This helper can be used to check if a cgroup-bpf specific program is
active for the current task.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/linux/bpf-cgroup.h |  2 ++
 kernel/bpf/cgroup.c        | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8506690dbb9c..655697c2a620 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -184,6 +184,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	return array != &bpf_empty_prog_array.hdr;
 }
 
+bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 03b3d4492980..19ae3d037db7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,20 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type)
+{
+	struct cgroup *cgrp;
+	struct bpf_prog_array *array;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	rcu_read_unlock();
+
+	array = rcu_access_pointer(cgrp->bpf.effective[type]);
+	return array != &bpf_empty_prog_array.hdr;
+}
+EXPORT_SYMBOL(cgroup_bpf_current_enabled);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
-- 
2.30.2


