Return-Path: <linux-fsdevel+bounces-75010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCY0FN7/cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:45:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D745365740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6B4F889724
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551043B8D6A;
	Thu, 22 Jan 2026 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="FeJXPWvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5183D300B;
	Thu, 22 Jan 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078135; cv=fail; b=LKD1tOer0L/IMM262NOBCxv3Kz8wnWGca8liEj+mmToDclZ4hoVE6hmMxqgtWOyR3iROk0+CD4bj7BvUTIujt3PZjeuVQVZ2MrVuGF/+5oPFLWcMHh/bSMdQ7KyNXAduBnbAbWvNbwB60rUtaZa78cf8NHOEe+X2MG2weg0HQnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078135; c=relaxed/simple;
	bh=mp1cwNc415safzz1H7apRZYNM3kNlIbNCL1eevctTQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AVDLBWgT79L9cS81eie3o9DvI4fWDclfTg2gfrPnO6A4TmXemyuFEVao09GqSbpZEokCzxTGlXnCv9gEq/z4G+QqIQuHhAVHChhKrtIENZZMxXxu0+05oRs5E+3mXAkxLU7qR9P74PnxDBRKTFovvs722oI13fiMgaUkfnmfpXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=FeJXPWvD; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020125.outbound.protection.outlook.com [52.101.46.125]) by mx-outbound-ea9-35.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 22 Jan 2026 10:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfsgGBk5UOFZL3EGNVPny+MsN19Bz0oqMODtj4+DgIrdYIqDDVxAumv4lT44TeO21cZyhx81iNBVbKD3AjmIBKtU/YGvN3Zf6NIctrdFt9qJL5P+eEVlBHapidFThq6e0E1G27AOPNE9EyrqMxLcpAJvLOJc1rBLyx55WqtAqOvD//ZZ9kvkMfWhz7uWWQv9bS95+kVs06ihZgBi4DZGb8j/hStX8ujE4MLRB9ua6sZXPKRL3bWHxYVKisNBfR+BE3v9sdEKK3/lKsza8gCK3owDf5P9qheRT9GbTtgib1QleJ0+aSRC4Z8B104ayO2X017mfWizToueRdC55F5P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSn3g7ey0wkhBkx+mIUxsImZoO13xrZLBXeFAdigHSE=;
 b=mpoXAbyUzxqqi6yiz6AVg8QsdT2mqGMMwdZZYUP+4eglxBg+kclDIKqltbJBzTscuq1cv75KJIUmtXgzLK36r7DOpEYpoksr1v13E/CS8ReCn3tbyFayu+lPTOF16fK7F31Pa3Ufwppu2CU7erMaGUhZGTGDYfg3HJZzyh17h9CzMWsUf7spvc1msomJ9YQwwS/OTNhdXIWqXu0z/xxhHGaP9zcR3HUKnX03uquwQbe8anOcGkMM1mqLg1gP4OBh4P0I3S742R5tc6JOrVHaXLhXXZK0Bd28MG4SXC4JFMjqTF942CTzVTwXV1ugHQ3YIZdm+WI84MZEByXhwEJmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSn3g7ey0wkhBkx+mIUxsImZoO13xrZLBXeFAdigHSE=;
 b=FeJXPWvDWIKab5Vta9eKFKQiMUT7Bz3oEQY7wjbbKBSpI30R4EMr//11ApNT87ISWDizEZrTXlNMup9psRgTWGzb17nta/NhgtrOBpLkYunhFdqIONXL8LVkiCQYCXQFxX7kBNPcY/HvDrozryUAJep+WJaoo67uXgEuZLHGdsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW6PR19MB8037.namprd19.prod.outlook.com (2603:10b6:303:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:35:14 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:35:14 +0000
Message-ID: <897e1f83-d36a-42e2-86db-fb5820666cbc@ddn.com>
Date: Thu, 22 Jan 2026 11:35:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
 Kevin Chen <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <aWFcmSNLq9XM8KjW@fedora> <877bta26kj.fsf@wotan.olymp>
 <aXEVjYKI6qDpf-VW@fedora> <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
 <aXEbnMNbE4k6WI7j@fedora> <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
 <aXEhTi2-8DRZKb_I@fedora> <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
 <aXEjX7MD4GzGRvdE@fedora> <87pl726kko.fsf@wotan.olymp>
 <aXH48-QCxUU4TlNk@fedora.fritz.box>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <aXH48-QCxUU4TlNk@fedora.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::17) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|MW6PR19MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: c46eb3e6-b6e8-45fe-89a1-08de59a1ed83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlU5V2NxckdXWDZOTUpUZ2ZLc3A3b1RsQ0gvNWJIUVNvY2dEWVJVanpSRVNs?=
 =?utf-8?B?KzNKOVpTSU92NHNpdW1zNURERHJnNzFyaWxsSFRieGxMTmZhM2NwUDM2bEo5?=
 =?utf-8?B?VE5GQW1nYVJQNFE3dUw0SzRvN1pGYUhnaGNjRWdmTGd6Z0o5VDhqNnJvcWhD?=
 =?utf-8?B?RWtKQUJVUEE2cE1YeEhKNGdKekpzdEFlSlZFU2o3a05NQ0hxVDFSUUFtSXVB?=
 =?utf-8?B?SEZJeEJsL3lEakJ0dGdPNmFQOWxNTWpVWE9jZXMzZlVPMDdTWEkyaHpMOUM2?=
 =?utf-8?B?YkNUbytiZHdLRTRRVTREU2h0VDFhVThWaEZwTnVEZ1EwTCt2cUNDbXR6SXR5?=
 =?utf-8?B?QkFBUWJGS0xjOU5ieS9qQUZSblFML2UzL0dwU3BybUZ4ZUgwVVAvUWowRENZ?=
 =?utf-8?B?MlpzT3FZWk9TTm9OdkE2bjZpRys3dUZaOHRwM2YrUENFck9Fd2wxZTBzUVdR?=
 =?utf-8?B?MGQ4TldkZjFzNW1TUC9FTTZNTDhLWEtjWVhaY0E4ZEhRY0FObC9tNnRGckJX?=
 =?utf-8?B?YWx1U3h5SWEySmhOZEVwVzFyS2tsMWxXb0E0d1dqOS9ieFJmMTAyU0lWb1Vz?=
 =?utf-8?B?VUJGNjJ5OXQ0eHlVdmRzREhiYTROaEpTS1B5WUJ3cm85cWtlNWpWdlhpWkpB?=
 =?utf-8?B?Z0lMNy9FNWttMitKY1lmWWk4Z2llbHlRY3p3a204YzlvbXFMTFRWRjlYdUR6?=
 =?utf-8?B?K3IyVWhhbEtJWTZzbkdrZ3EzK3ZWeCtxMGFIMUtycjBXcUhoT3pjakJTZ3Jl?=
 =?utf-8?B?MGJuTGd4WXZWM0hKYWEwRGNSVlROSkIyQW9BZmtHSHNBbXRoWFpHNER6SlZ1?=
 =?utf-8?B?MzhhZ08wUnRKVUJkMk81WWZIVVVwOEtBQ2ZhbmhQUUdoWkRDMGwzeW5ob0FW?=
 =?utf-8?B?cW1LalZjUE5HeG4rL0E5TkVjREoxZGJEQXhCU09CZncyTHRlTFlJNmtNazBV?=
 =?utf-8?B?eEFMM2ZSNEplZnN0NnRWYUx2NktwVmlQems0cXcwbDd3MFhsK05aZkl6NHJi?=
 =?utf-8?B?SzNFanM0MlBYUWFsNUpGTFlPWW56cm5wc09Id0pHZ1JiWDhrS2xqRVNnQW5C?=
 =?utf-8?B?MnpxSTJwNlg1ZTVhQkpsV3pSUklob2RyS2tJb0NoWUtPMmc1NjE3SXZMcExQ?=
 =?utf-8?B?K2xER0NHTUdSZFBmNnRqQktNbzdIS2djOUJScUt0UFd1UFN3ZDdiZ3YwS2dX?=
 =?utf-8?B?dFYyRmdYUExsV1VEMC9IYnZCL2tZYzdza1dtY1JWSTN0by84cEdJUEVDRUFV?=
 =?utf-8?B?QVRKVGRrUUFqcUV3L2d4dndSVjlPNkpqSkwwVS85NVk3ZlhOcDJ2Y2xGNGx1?=
 =?utf-8?B?UENLMGNKWlJncURXZHlhd2pYQ2lqOHQ4Zlp2OXkrWlJ6TkRrLy9yNjRvVWdB?=
 =?utf-8?B?UDREc3AyVjFrNGwydTFNMW54cDJDKzBHM2RBL3cxWTArd1dRV0ZsWDZtTU5V?=
 =?utf-8?B?Q3pOckFUSDRSUTFoZnNHMmk2allnMXovQis5UlNlNzdJVFpSdm05cVA5eU9i?=
 =?utf-8?B?WERmeFhOTS83anlwWUNDNHpCQTZuc1drWlZyenh4OCtob09BSEV1OXllSVow?=
 =?utf-8?B?RVRSd3pwMkxRaCt5a3AzeXpIY3NiZFZ4QllEUWl3Q3RTZnpKaTFPdzF3L2tM?=
 =?utf-8?B?elFnR2Y4SXlSUVZYYmZHV25xSzBSZmpTdjVNekpJSkNFS0VPaFFoSHptcXFl?=
 =?utf-8?B?dVdCeDhuUFVxY0pmVnpvYUdMNU10QVgvb2NScXgxNElia3NqYnMzeUhlSnhQ?=
 =?utf-8?B?bEQvWW9mZ2NOdEFUalZ3QzZYZ083WUlUV25sRERvd0xLU1hLeHFlL2ZTL2Jv?=
 =?utf-8?B?Z2NoVmMwNGJYZVRFWnJxekRDN2w2MHZIcnhuMVVQMFYvSFplY3Bla0JDZU9Q?=
 =?utf-8?B?V3M0MGY1S1AweU1mQ0pvUlFNODZ0VmUrTlNxQU5rNmd2REsrd1Fiblg4Vmhn?=
 =?utf-8?B?SXN1VFF4T05pVGNZazZaL1lZeXZDTlJ3L0cwUXhxZDZjc3BnQkdvajV4dHBG?=
 =?utf-8?B?WTJJb1pvV0FuY0ZEdVgrVmZmYUVTV2NDY2R0czFLWnBVeU1yUmpCUm1KS1hr?=
 =?utf-8?B?ak9vMGN5YU9yd3B5QkE0ajE4b2xYVTNmMnhLNnZkeEFYb1cya3kyUmREdENJ?=
 =?utf-8?Q?YsoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VKbW1aMlFiN2prT0QzckhFV0JGTjZPSjZXaytqbTl4M3I2K2FvMlNlRWJs?=
 =?utf-8?B?TlRZTUxxNWU0aHJHaG83UldycGVBamVkSDhsZlE3SVFFZlNXdVJ5c0o5OTcw?=
 =?utf-8?B?UDI0Zk5raTMxZWRwQm5aOU1iUUQvQWNUNkt1V2JibTh6OUdjWE9FYUlOaUov?=
 =?utf-8?B?KzBiVFZsRXRrRzZxZStYS0ZoWUc5dUZ5K3BrdFRsNVFtTTBPOTgrZWIybVU2?=
 =?utf-8?B?QmthRXVaUDU4OGIwTVgzUER4aUxrMTJmeFZKRGtDdk9sYjJ2M0FjUW16ZFhD?=
 =?utf-8?B?c1VVcS8xSnNuNDFyajN3S3M1SXVzRlBySGF1b1Fqb3V6U3VGZmNiekcrRDIx?=
 =?utf-8?B?YVZpVitYZlJlWkpCZXROOWFmQnc0M2J4VHVCaE40NGZkeW5Gc0lVZ0dEWUg3?=
 =?utf-8?B?NS93Nm0wS29SL0JSTmIxaC9GdFFSeVNNL0xnVGxmaHF2V2hhV2JCTjlSNnV0?=
 =?utf-8?B?U1NTWXZ3TzdqTmZoUHEwODNlbmE3dDVHV2NSUWJ5dzU1bitYSWZqVm1ja001?=
 =?utf-8?B?K29jekdWdU1tQUYwQUpHOCsrRlJYKzJNSXZLVks3aW1tNXZ5alFMeDZnVGg3?=
 =?utf-8?B?T1BYT3UxTXFYeWg2VEpMTCttMG9PYVVtZSttU21VZ0R1V1VQZndKTXpRRk5i?=
 =?utf-8?B?VGp5S2JmMUU5L0pNUm44NURtYkFJd3pkdWVESnlmOTVvT21seHdmaVhuNlJC?=
 =?utf-8?B?R0dzbVpOYUR1VHZuL3B4eEt1K1V0ZlRkUTZZbkFxRWoyMGdWVHRFUS9JblI0?=
 =?utf-8?B?d3JKTmJjRlV6NDRtK0hFUDNlUDhPQU5KWEUxYjY2QkVLVlBvSzBsNzVORzdn?=
 =?utf-8?B?UVIwSTRmRlFKcmVkb0NJckNidVd4empRWm9yQ3ZTQm11L3U5TDhJZjZJZTFV?=
 =?utf-8?B?MTdIRjNvaUNEZm4yN0dPaE5UNUhvYzlWbWhhVjZwbGgyNllFNHlGdmhaTFhF?=
 =?utf-8?B?SGhpK0xqeE5PbU1vVVh5WUM3aExYQWsyaXZRRU9uSkpwb0lYQXRpd1JJdkhV?=
 =?utf-8?B?eW9tQnNzRTd2WTJYaDl5Qno5Q2kwODFNSTUzNXBXMk52MUdremhyLzNxeGhC?=
 =?utf-8?B?OGNCSk41UkQ4UDFWL2xTdGxBTW0wWXIxeVFMQW1UZ3ZpT2hVeHlCcnVodFc1?=
 =?utf-8?B?MXBLWG5xMFhzYndNL1ZlR0kwVHE4SmhNRzV6eWdpbUFoOVBoZEg5eHBQa2Ex?=
 =?utf-8?B?UTcvVnFZUUgvQ09PTFBIaFBxU09CRHNhQXBhS2FLRS9lWmYyTlU5bkhCWHhL?=
 =?utf-8?B?elN0RzQwTm1td0JkSU11VGJHcnBiSitPbExmaWVpNUhxL3M3aXRiandkMkR6?=
 =?utf-8?B?d3llVlJiQlBPaUJWN3ZYSlpRRWszUDNpODdxQWtiZk5oNmRsb0ViVG02SFMv?=
 =?utf-8?B?bFdFZS9FOGJLL3ZJYk5UMmlxbU1KODNpV3dsUFJRQnM0dlk0VExGZG8yZHVI?=
 =?utf-8?B?RmhOeFhjNERpQVhtV2VXQXRDeEw2WjJKd05xZDc0cDVDcHgrU1dQZFZqRmY2?=
 =?utf-8?B?UjNCTjhMVmdyQnRNcE9jUFZGa25Zd1dFSFBObUw0bm0yRWdpeFFiZGsyNmRW?=
 =?utf-8?B?ZXU5eTVaVHZSREJQUWwrZUg0dmZGYkZHOHM0YkxSKzZBUU84NWdoS0ZlMEpO?=
 =?utf-8?B?cHhDaDJnZjdDK0N2RG1BeEt5Q1h6bEJCUUVYYks3SnBkdnBMenRuMUNwV0xa?=
 =?utf-8?B?NjlWNGp3d3c3N2g4bFI2a25aWTFvTEVUczJZNTgvb3lyTDZrbUpzM0dQS0NB?=
 =?utf-8?B?Q2lkVnV0MmlyMEhoN0FHTHRLcVJocGRRa0k3Q0VVUUNIMGtJYUlxQnFCcFNz?=
 =?utf-8?B?alVLTmIvYWVjblB0NHExbG82RFpZcEsyQ2FVbUNtK2F5VXErOEtrWWRsdzhE?=
 =?utf-8?B?ZHp6ajNCMnI1WmpyRVFxV1ZrNWsxL3pIalNGb2RnUjdrd1krdFRnd0xYMUll?=
 =?utf-8?B?OFJvSDBWTFFuSE51VmFmdGRVaHRSODFEbXU4MkFFcmF0UVVGcnJ5cGtMRmcv?=
 =?utf-8?B?aDNQaEtYZDllcGxROEwvY3VzdGNYYWs4cUVqY2kxSHphbUt4SWZac0RkKzJs?=
 =?utf-8?B?K3g0QXc4UTZpU083SU0wOVd5ME9FRHZDa2pZZ0lTMTI5THlpOEtjeHpNQzlp?=
 =?utf-8?B?c0NOSDdSeUlLUEN2OXg4MGI3VS9KWnJ3d0xMZ3R6WDNhV2pSS3V3RDZseFdD?=
 =?utf-8?B?bVhSV1E2SC9GdkpqNlhCSnV6aGNkWE1yWnlmb2Q5MHFEbm1zWVJoWnpFcGht?=
 =?utf-8?B?ZHNVakJiYjRJKzVubUNmQ2lIVUoxNHFJeFdtcm1ISklqSmpybU1BcWsxcmxl?=
 =?utf-8?B?dzltREkzRVI5MzltbExyWEszZWptbUJUZXBBQVVGUFMvK05jWEplZkdCVlpu?=
 =?utf-8?Q?o6ucxKEfKfYFSNP6AH28h8tGN3VGqrw2l4wfMIYDlS/4B?=
X-MS-Exchange-AntiSpam-MessageData-1: ny2ONux3iiGkbA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IBF4rCGVHBfylcC9zKdzk0k5/CDuZ7AZoGj6h5a/pCUrtReT+shx5EOu4+CwdzMffFCADIlzKw8tA1Njh4THhJyX8s/rZSG1/Ct+wvIAhzy5fCveEFIa8Dnf/hGIdTHoxNVUQq6K8eCrSST5eLXUiL9HeNaXUaN/juKIhpX6KWky9od/3o4BkZLryMCtJdIio7rdV9k75ldcEKlU+Ikb3gL2PKnCy/8PL9bbvU+X++/a0uFhSM9c7FN7VnMGFEBhlQn0+moAcSrWCG1825BIancVJqzcHizF1lcLUWcpSBz9Dd3k+LmUgsS2F1eTZJ5xlZQuGVSniAVFTnnoASk9RBSnHQMV8SOH/szWPGbz1KAZWJIaH4g/bqNUt0BoPETl4v97P0hxjFS9J01aEcm66PKwyWo8ccespP/gUHKBORXlBBmyzzmsd9fsp3TqiuuOrs4e+wnYRw2oLDWnc6JEmcunqZQKKUEf5fLBO3vRPN1UCqcQ4wPzbobNTEMLWYChfaik40TZxTGU1YBXLc1QQ8akbzwQyB4tEr5KniCmZz7MUVYFwJn5iBRL9pxaUsZcn0fgDL0oy01TWNo+sFTqDkATAbVXWYkGpQHZKjXdfAHQHNtFyJWd75SAQCOmRAWoZmCBSR8Sfz6xYlBqpApnMg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46eb3e6-b6e8-45fe-89a1-08de59a1ed83
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:35:14.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+fdmuRaUlnG0pd70YJGMtowG0kq4nwzFE3BBk1bCPj3OBonA46TkowurGIiiTcn+4GILxLpKrJ8L7XmR8Alag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR19MB8037
X-BESS-ID: 1769078116-102339-15828-20438-1
X-BESS-VER: 2019.3_20260115.1706
X-BESS-Apparent-Source-IP: 52.101.46.125
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbm5uZAVgZQ0DLVzMjUwNjU1M
	wyxcwg2STV0CA5Mck8xdLIMtHU0ihJqTYWAL2D0OpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270581 [from 
	cloudscan8-78.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ddn.com,reject];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[bsbernd.com,gmail.com,szeredi.hu,kernel.org,ddn.com,vger.kernel.org,jumptrading.com,igalia.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75010-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ddn.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,ddn.com:mid,ddn.com:dkim]
X-Rspamd-Queue-Id: D745365740
X-Rspamd-Action: no action



On 1/22/26 11:20, Horst Birthelmer wrote:
> On Thu, Jan 22, 2026 at 09:52:23AM +0000, Luis Henriques wrote:
>> Hi!
>>
>> On Wed, Jan 21 2026, Horst Birthelmer wrote:
>>
>>> On Wed, Jan 21, 2026 at 08:03:32PM +0100, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 1/21/26 20:00, Horst Birthelmer wrote:
>>>>> On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
>>>>>>
>>>>>>
>>>>> ...
>>>>>>> The problem Luis had was that he cannot construct the second request in the compound correctly
>>>>>>> since he does not have all the in parameters to write complete request.
>>>>>>
>>>>>> What I mean is, the auto-handler of libfuse could complete requests of
>>>>>> the 2nd compound request with those of the 1st request?
>>>>>>
>>>>> With a crazy bunch of flags, we could probably do it, yes.
>>>>> It is way easier that the fuse server treats certain compounds
>>>>> (combination of operations) as a single request and handles
>>>>> those accordingly.
>>
>> Right, I think that at least the compound requests that can not be
>> serialised (i.e. those that can not be executed using the libfuse helper
>> function fuse_execute_compound_sequential()) should be flagged as such.
>> An extra flag to be set in the request should do the job.
>>
>> This way, if this flag isn't set in a compound request and the FUSE server
>> doesn't have a compound handle, libfuse could serialise the requests.
>> Otherwise, it would return -ENOTSUPP.
>>
>>>> Hmm, isn't the problem that each fuse server then needs to know those
>>>> common compound combinations? And that makes me wonder, what is the
>>>> difference to an op code then?
>>>
>>> I'm pretty sure we both have some examples and counter examples in mind.
>>>
>>> Let's implement a couple of the suggested compounds and we will see 
>>> if we can make generic rules. I'm not convinced yet, that we want to
>>> have a generic implementation in libfuse.
>>>
>>> The advantage to the 'add an opcode' for every combination 
>>> (and there are already a couple of those) approach is that
>>> you don't need more opcodes, so no changes to the kernel.
>>> You need some code in the fuse server, though, which to me is
>>> fine, since if you have atomic operations implemented there,
>>> why not actually use them.
>>>
>>> The big advantage is, choice.
>>>
>>> There will be some examples (like the one from Luis)
>>> where you don't actually have a generic choice,
>>> or you create some convention, like you just had in mind.
>>> (put the result of the first operation into the input
>>> of the next ... or into some fields ... etc.)
>>
>> So, to summarise:
>>
>> In the end, even FUSE servers that do support compound operations will
>> need to check the operations within a request, and act accordingly.  There
>> will be new combinations that will not be possible to be handle by servers
>> in a generic way: they'll need to return -EOPNOTSUPP if the combination of
>> operations is unknown.  libfuse may then be able to support the
>> serialisation of that specific operation compound.  But that'll require
>> flagging the request as "serialisable".
> 
> OK, so this boils down to libfuse trying a bit harder than it does at the moment.
> After it calls the compound handler it should check for EOPNOTSUP and the flag
> and then execute the single requests itself.

I'm not sure. I think the server compound handler should call into
libfuse as it does right now and ask libfuse to handle it, if it doesn't
have its own handler. But then it needs to be safe. I.e. open+getattr -
cannot be enabled by default, at least not the getattr part, because not
all servers will need that. I.e. server needs to set bits to libfuse to
enable some compound operations. Things like atomic open probably could
be enabled by default.


Thanks,
Bernd

