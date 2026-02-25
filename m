Return-Path: <linux-fsdevel+bounces-78361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPL7MOXpnmlOXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:24:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF31973DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1AB8301DA66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165B3AE718;
	Wed, 25 Feb 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XYpjWP31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020111.outbound.protection.outlook.com [52.101.193.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC483AE6F8;
	Wed, 25 Feb 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022224; cv=fail; b=IosK3YHd89qtEq2SVYPfsJ/4tk6RYGIX47y3wwtEYMdb05+1OjBq+O1E+nwLclaPuF51iizZRAnfZqD5pI1Iz3rqr80N18SyXtnYLzW1al+ouGzcowu3hHKQalAjeqBgF/ODJkfIvgQIwSitKSQZ3yaV+yMMX8dCll5Qp35XZAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022224; c=relaxed/simple;
	bh=atQaIQfVNz6uzlRTlTnLuHBX4Lt0gBRSDzbxeJ9/kUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfiVZoFzAonGhV3V1z3aR52b9kyIuazK6LlOyJyXQrM1BWzTGO3lfVFW/tHlajxgQOSA+yGQGlBvLtAd6FUQagVK68HskptkNT++2CrYTq72tSEtTIXdoMVRXQeFNfLi0iN6WU1Do7IRP2CQsZG6s9iSCpShpyLBEeA3biAkFkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XYpjWP31; arc=fail smtp.client-ip=52.101.193.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Okx7879TyPzuwrZiYfAG1qU9w5evvuHq6lxmiZMBmXUGlQAYacbPo4v5NIsWlw9AyySAIG1omHzp5qiUqvwcKwwj4hmaYE4rOBuUMUcuKm1H1LMWJxJCNr38GyxNoNb+cJvgMhi5TgDVpSQ+TUCIPe1ZO4ZZ8qoIAy9qmnALu+mUJtKjrcO1CcOuFipShKSvbFWNxNvIaTYZrQRhcOmhTyAqaddNfMdqXPWplfoNUqlZpTfqJVXLBj23JAP0lAMhwn+yNUQPP2+WASKgkZsygw5vWVHCgATl83ZTho8WZS23S875g6K+C4iWszcM4g62KGpdzkz2+itlCamSqVAOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1glUZvkHsw235KPTNihY0LkUbvo9MrGVFa0hLTSk30=;
 b=qpaqiep8Z2BQJY4z2+P1fbSd8NkuG6Bu95yGbiRHc37XfDsbV0AyEkyK/sP1YsOo9CQWq8fNIwZwelqxSQZpqiDVbSK1w+lL7rtT5l9fGgdbUcIxWc39HI5xcJppsS5vPY2setBG6rIoMS8y3pnCwIKx4Sn78wtrV/wcZVWcxn4hiFh+ORUqO+6R4abhZxjbEYJJw3i3dXEr5ZVY3yIH1kVPOXWcspz03GrziCE7IkxatWJUDdc5O5z5DiXqi6POeOqdjug7D6USGo9iy37H1as5y4q77NM5Q2yE4hYb1L6mY+W1O0OzEQYdPnmyYbKC/uowD54/6RsaLz744ZgQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1glUZvkHsw235KPTNihY0LkUbvo9MrGVFa0hLTSk30=;
 b=XYpjWP31G/UoutVcwNcAS1YTHoUEaycTWWwNvDZ6JNuU5M+B6phgKYUtTl+5ZSMwFsugEk/RCHTxl+LtfjxAtIaB7ts1etHMhSXEEGGooRITa8oQovizqxA0/6yzihlB8Sbh8xQoKRFJm9vFdxBx7/tvnIy9Lv6iw6G0/7mJMqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS7PR13MB7379.namprd13.prod.outlook.com (2603:10b6:8:269::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.13; Wed, 25 Feb 2026 12:23:38 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:23:38 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 3/3] NFSD: Sign filehandles
Date: Wed, 25 Feb 2026 07:23:35 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <025AD576-CBDD-4477-916F-7397585351AA@hammerspace.com>
In-Reply-To: <c64ca6ae0f2d948f42b454c87ebcc58edee8bc3c.camel@kernel.org>
References: <cover.1771961922.git.bcodding@hammerspace.com>
 <6ca1559957e3ebe3a96ac9553df621305a4b33ea.1771961922.git.bcodding@hammerspace.com>
 <c64ca6ae0f2d948f42b454c87ebcc58edee8bc3c.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0047.prod.exchangelabs.com
 (2603:10b6:208:25::24) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS7PR13MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: c69d0590-8217-4a8f-c27b-08de7468b407
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	zaDJqktSbsPOFU+P2Mp2CGK8PKWzIibp7sqTuUuRtbGg2knBdgbOp0y6PEDSvUGhzBz+guv6BguQRA8HEtFBoV4uqxeSl/wxkHA+ciyQ9VP63b4Nhdk9M+QnmwkXls1GLgPDbDOfWY+bOPHIQ0PY1AE6sBLmiBIwLWr0W6qySfScasWUSR/KLyhhcZHH13fo/3MoiPHG2hj01HO3etd1icm1tcz7RLcmXcw1VqWEIoc3DCdzOuDpwffYhYy+toNc9+JVXtbsnTxskL3v34aqlmyif4Hy+b7QH3A47sthAc2vMnL1UR8nVhaeYBPELZaGThHT00Cz3OcJySmi804887+LH+5gnR3Sx8Oh7NdOB5XoKG8ubOzoRSX+kRMnSlQmjnVDQbTnTgOch0jZQ320dy1YfEDGO42HYTTlVK21voWFXbI9LCJpx+s2mvgpGsUAIwVtswyRN68oaBxs6PhzA/725mLoxy/3zPSlU6IMHvxQ5NTOdVnnWPMg06XbJsM1fXw6TIMHnN5PPc9x+MlF2PjnjWKtZWML60HTWYojwmfMVZDu+CCGeeRwhB7g2rY5+keWa3J74VUIFky9P3K2qshlTcKnNjduiRnlo9JFRn/oWn8xKfIWecspV49F593kuGmr+q5zb9diSzEVF7A/6MYGDEE7qWFNi7sqy0zDqeH/hQ0mud5u9LjODi3MPwSO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RpubJu6432N0ILOvle/ioOkCSpAe/RibWFamDiOcbYBMH6j3KA7mWisYHaf6?=
 =?us-ascii?Q?gTdKgV3MBeAPDmxmH/LYwohNFv5nWjs6uIK5DsXIRtNEtnoNmnsthkcxDzTX?=
 =?us-ascii?Q?HjVokmGKUawEORjDVcqXuzq9HS03rS0P/yzTKnjDHDH7BhE7g3O1i5mLMRyz?=
 =?us-ascii?Q?J0GNROQQxN8KLrxJAEDvATpELISG1MUM8etGtF3h1ClgCBcGz1Ky/FddMopV?=
 =?us-ascii?Q?DTKRIG0BO9h0M472KEF3OhB1dSWpAMsjjzaRQC09dgrBB8uc42bXDz/DEDEP?=
 =?us-ascii?Q?dOs7noL714rbJG+bt9aYnnTed5Y1hi+n+DMZ3qCSMKrAAvoftZg+V6cnWzwR?=
 =?us-ascii?Q?PpKwIXaBCO/JEYClQVG1M+YVgMekljJeEbeSzXoy4r/5EBSNeFkepchPC7z+?=
 =?us-ascii?Q?qEfzyAJoH443kWkgnO8jExhioCJZZO4zKbThbxad+9r4jAAH3JoCkTllZ4qt?=
 =?us-ascii?Q?p7StA6g3kC/+DN/OoRIIlN5rxoGM+Smx9A6gFIt+eqVQXqawk06OIFjhHXbZ?=
 =?us-ascii?Q?GV9DxOXjFy2gHXd95TS2DCmfRI5CajvWcsY02MHtWvaCvs1am0pCLJxAKOD/?=
 =?us-ascii?Q?mbWze/6RKH5NUAOuSWZCrN0alkFfEcWr5820wEiQ0lq7GLyY5lTzNPbyUgud?=
 =?us-ascii?Q?Ibtb0Tg2S5IY8FLFVxI8UDNyTTJgFiF0+Ea7kweiW990LOwywzEU/i021RJQ?=
 =?us-ascii?Q?aEc8VLVK2/IV0bgQceWnyXEN/PC/10jvA1PTDcOJ5iJSTDSXLxklMMcpQg6y?=
 =?us-ascii?Q?/b7OtxTo7nxm3HfglkE/50Wf54JdYS1VN4RWA5soi7fGq28OfPhW5pNo0oJ4?=
 =?us-ascii?Q?5oVWPTcM39IxuoBSMNbGi182gOv2MTs+wCEBGeHscg4F36shLOEvZv0Er/Wb?=
 =?us-ascii?Q?+qhmhU+l0RWTfiNsuFA5AkloLNb23exLuNygIDIgHsp9yVHs3wtj7GQjVLKF?=
 =?us-ascii?Q?TWPEPfzuWtqESJwPvUzA3sUFGc2oC9RO3YYziheLzD+4kfcFm0jUNMQ//B3I?=
 =?us-ascii?Q?BcQ+A8D45FAwM4u4TF9sfC2Mhs4h1y4RWfGpO/WfO8Rz2knT43DWeJ01Ctak?=
 =?us-ascii?Q?V8NCpHoLGrpUrOuQWEhdn+3w2sii9J5AvXX7eoSbgFWGS0HHxJZa3VFnugzW?=
 =?us-ascii?Q?K5GNhqk5+9sLYvZdGyioFymWtQ8KhiFjWPONoBN3jZceLE1VlcbtIkofOnMQ?=
 =?us-ascii?Q?kF1QdtG2HJ1mnuXIy1NElPPQPhuFuw82TqlQrqdO2uOQk2lSQYy/0r3fBwRT?=
 =?us-ascii?Q?rKcWuak1wBtoxzSjkKN8H8K3WjMOWiExzFCTVVUzLfOci7NEz7upFJm8mepC?=
 =?us-ascii?Q?oqtL/R2Ukh88DhT6WvdwKFts9Sak7wIdxbMuXJcPDWtii4yXN7ERhWSXYlRo?=
 =?us-ascii?Q?/D4UBTWuXjD/2yn6YzsY5aQZ60ekK9GeZAerBT6IUWpebdgLziKiirQ7aaC3?=
 =?us-ascii?Q?0LkaXo4kZeFWCKp6tHBtL86vzItimm+JUROdzNz1OlXZVxByfuopYx6VFL8g?=
 =?us-ascii?Q?+ypgp5sjAIqeXiSbes56QExj6Hgqu2PbJHqSrch/WVBCTJdAyXTeJjssPHt6?=
 =?us-ascii?Q?q9k0kABm5e9nETB1RE4InI31TtHk5r0Y5sFm10xOhOKIKOzd6ojPcRw81v/U?=
 =?us-ascii?Q?1D2iXLgdl0yH3pxlU1M6no8ROu+mELnQxlfY8AO/2awxF2Fa48VcLv1RLvQ/?=
 =?us-ascii?Q?MW57xpshlALzk1j2AW1dfY9R0WFoBBSKpvYXYkPu7ZVlUGHtEjA/tu3xDFQP?=
 =?us-ascii?Q?z1kzxVa0G8kTwDLA/JbHyyH1P8SDIRo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69d0590-8217-4a8f-c27b-08de7468b407
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:23:38.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F5CUMX+NUA4e58cA+P2j7Q9/O8Xu6uuYJyE66XFAy73zHTmQcaSfcCWNSdHEDeMgY4B+HQEVOzQt3CbtbvXk9n4pyd0uL+UHjLze2SaI/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB7379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78361-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.918];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yp.to:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: 19CF31973DA
X-Rspamd-Action: no action

On 25 Feb 2026, at 7:10, Jeff Layton wrote:

> On Tue, 2026-02-24 at 14:41 -0500, Benjamin Coddington wrote:
>> NFS clients may bypass restrictive directory permissions by using
>> open_by_handle() (or other available OS system call) to guess the
>> filehandles for files below that directory.
>>
>> In order to harden knfsd servers against this attack, create a method to
>> sign and verify filehandles using SipHash-2-4 as a MAC (Message
>> Authentication Code).  According to
>> https://cr.yp.to/siphash/siphash-20120918.pdf, SipHash can be used as a
>> MAC, and our use of SipHash-2-4 provides a low 1 in 2^64 chance of forge=
ry.
>>
>> Filehandles that have been signed cannot be tampered with, nor can
>> clients reasonably guess correct filehandles and hashes that may exist i=
n
>> parts of the filesystem they cannot access due to directory permissions.
>>
>> Append the 8 byte SipHash to encoded filehandles for exports that have s=
et
>> the "sign_fh" export option.  Filehandles received from clients are
>> verified by comparing the appended hash to the expected hash.  If the MA=
C
>> does not match the server responds with NFS error _STALE.  If unsigned
>> filehandles are received for an export with "sign_fh" they are rejected
>> with NFS error _STALE.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  Documentation/filesystems/nfs/exporting.rst |  85 +++++++++++++
>>  fs/nfsd/Kconfig                             |   2 +-
>>  fs/nfsd/nfsfh.c                             | 127 +++++++++++++++++++-
>>  fs/nfsd/trace.h                             |   1 +
>>  4 files changed, 210 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation=
/filesystems/nfs/exporting.rst
>> index a01d9b9b5bc3..4aa59b0bf253 100644
>> --- a/Documentation/filesystems/nfs/exporting.rst
>> +++ b/Documentation/filesystems/nfs/exporting.rst
>> @@ -206,3 +206,88 @@ following flags are defined:
>>      all of an inode's dirty data on last close. Exports that behave thi=
s
>>      way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
>>      waiting for writeback when closing such files.
>> +
>> +Signed Filehandles
>> +------------------
>> +
>> +To protect against filehandle guessing attacks, the Linux NFS server ca=
n be
>> +configured to sign filehandles with a Message Authentication Code (MAC)=
.
>> +
>> +Standard NFS filehandles are often predictable. If an attacker can gues=
s
>> +a valid filehandle for a file they do not have permission to access via
>> +directory traversal, they may be able to bypass path-based permissions
>> +(though they still remain subject to inode-level permissions).
>> +
>> +Signed filehandles prevent this by appending a MAC to the filehandle
>> +before it is sent to the client. Upon receiving a filehandle back from =
a
>> +client, the server re-calculates the MAC using its internal key and
>> +verifies it against the one provided. If the signatures do not match,
>> +the server treats the filehandle as invalid (returning NFS[34]ERR_STALE=
).
>> +
>> +Note that signing filehandles provides integrity and authenticity but
>> +not confidentiality. The contents of the filehandle remain visible to
>> +the client; they simply cannot be forged or modified.
>> +
>> +Configuration
>> +~~~~~~~~~~~~~
>> +
>> +To enable signed filehandles, the administrator must provide a signing
>> +key to the kernel and enable the "sign_fh" export option.
>> +
>> +1. Providing a Key
>> +   The signing key is managed via the nfsd netlink interface. This key
>> +   is per-network-namespace and must be set before any exports using
>> +   "sign_fh" become active.
>> +
>> +2. Export Options
>> +   The feature is controlled on a per-export basis in /etc/exports:
>> +
>> +   sign_fh
>> +     Enables signing for all filehandles generated under this export.
>> +
>> +   no_sign_fh
>> +     (Default) Disables signing.
>> +
>> +Key Management and Rotation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The security of this mechanism relies entirely on the secrecy of the
>> +signing key.
>> +
>> +Initial Setup:
>> +  The key should be generated using a high-quality random source and
>> +  loaded early in the boot process or during the nfs-server startup
>> +  sequence.
>> +
>> +Changing Keys:
>> +  If a key is changed while clients have active mounts, existing
>> +  filehandles held by those clients will become invalid, resulting in
>> +  "Stale file handle" errors on the client side.
>> +
>> +Safe Rotation:
>> +  Currently, there is no mechanism for "graceful" key rotation
>> +  (maintaining multiple valid keys). Changing the key is an atomic
>> +  operation that immediately invalidates all previous signatures.
>> +
>> +Transitioning Exports
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +When adding or removing the "sign_fh" flag from an active export, the
>> +following behaviors should be expected:
>> +
>> ++-------------------+--------------------------------------------------=
-+
>> +| Change            | Result for Existing Clients                      =
 |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> +| Adding sign_fh    | Clients holding unsigned filehandles will find   =
 |
>> +|                   | them rejected, as the server now expects a       =
 |
>> +|                   | signature.                                       =
 |
>> ++-------------------+--------------------------------------------------=
-+
>> +| Removing sign_fh  | Clients holding signed filehandles will find them=
 |
>> +|                   | rejected, as the server now expects the          =
 |
>> +|                   | filehandle to end at its traditional boundary    =
 |
>> +|                   | without a MAC.                                   =
 |
>> ++-------------------+--------------------------------------------------=
-+
>> +
>> +Because filehandles are often cached persistently by clients, adding or
>> +removing this option should generally be done during a scheduled mainte=
nance
>> +window involving a NFS client unmount/remount.
>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>> index fc0e87eaa257..ffb76761d6a8 100644
>> --- a/fs/nfsd/Kconfig
>> +++ b/fs/nfsd/Kconfig
>> @@ -7,6 +7,7 @@ config NFSD
>>  	select CRC32
>>  	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
>>  	select CRYPTO_LIB_SHA256 if NFSD_V4
>> +	select CRYPTO # required by RPCSEC_GSS_KRB5 and signed filehandles
>>  	select LOCKD
>>  	select SUNRPC
>>  	select EXPORTFS
>> @@ -78,7 +79,6 @@ config NFSD_V4
>>  	depends on NFSD && PROC_FS
>>  	select FS_POSIX_ACL
>>  	select RPCSEC_GSS_KRB5
>> -	select CRYPTO # required by RPCSEC_GSS_KRB5
>>  	select GRACE_PERIOD
>>  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>>  	help
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index 68b629fbaaeb..383d04596627 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/exportfs.h>
>>
>>  #include <linux/sunrpc/svcauth_gss.h>
>> +#include <crypto/utils.h>
>>  #include "nfsd.h"
>>  #include "vfs.h"
>>  #include "auth.h"
>> @@ -140,6 +141,110 @@ static inline __be32 check_pseudo_root(struct dent=
ry *dentry,
>>  	return nfs_ok;
>>  }
>>
>> +/* Size of a file handle MAC, in 4-octet words */
>> +#define FH_MAC_WORDS (sizeof(__le64) / 4)
>> +
>> +static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
>
> I get build failures with this patch in place. This function is defined
> here....

I did that thing again where I fixed the tree and didn't regenerate the pat=
ch.  I will resend this.

Ben

