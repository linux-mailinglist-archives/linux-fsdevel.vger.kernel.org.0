Return-Path: <linux-fsdevel+bounces-74699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF16MnLXb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:28:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D934A618
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B6E9EBC95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FCB34D4C9;
	Tue, 20 Jan 2026 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="DwwvT/Ca";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AqTheCf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-174.smtp-out.amazonses.com (a11-174.smtp-out.amazonses.com [54.240.11.174])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E129BDBC;
	Tue, 20 Jan 2026 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928741; cv=none; b=Jn4NUJ7TBWYKZlhXZQF7nQnYq4VfBbqLaEnb9X/VTwA/uLYXhnG4M0Q6eLOy3qbji0qAqbz3GJOwHb5yGocW/jbv4N6pQcLdiqCS0QRZVEXeio5Es13m9UuHMP23zaHFfAREHA5zBAzPqcWZIwsRuwzGXCc6oS5gEZZqlRLly5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928741; c=relaxed/simple;
	bh=IMQm6fDafW7KCFXpTWzI1T1mVxi+bppakZwCsXXVpN0=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=OsXDQP6BLekwRV0oR5Fg5AnHxKCOFvwoeYXCQNVEJ+9f7ETaQq78oakUEV++sf+qOARLpk39BOVmSle+JY0URjbrYR74GpxeEMg9KoJJQHpI/6NpJnhBdNSqapYiZhV5GN6WwspeyXZ7S/McBQhQBS31A+sF/OnF94RvqazhRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=DwwvT/Ca; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=AqTheCf1; arc=none smtp.client-ip=54.240.11.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768928738;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=IMQm6fDafW7KCFXpTWzI1T1mVxi+bppakZwCsXXVpN0=;
	b=DwwvT/CaYNuc7K7TdH9FsPGRrWinrPHVAaeiwpLarvY8rjJrXr+ktepNJwcLjbWj
	IdkKiVyhCez9NFtH0D2ikhBZyXbWVIP3/gAPGU9buF1+swiDqwIcmHt8KkYw4+eFDwC
	1ujydogbkB0WSDT3oQjVEjMjDi4Gd4OF1fFTCfbU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768928738;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=IMQm6fDafW7KCFXpTWzI1T1mVxi+bppakZwCsXXVpN0=;
	b=AqTheCf1cAVTYTfY0RSVgNQe5o6AA+AjkFT1z86y2GS+SR2RRuERd/nEBVVSo4+O
	OTsbT6vFhj27Plbnoy7GR2cQxWQCMpovP0V/+BQF+IjVytSwOnsviUSlGUAn+90kLue
	nibBJFQFeEZ2R5WXFZrJJFKR6IFSmZW8nrpNYMR4=
Subject: Re: [PATCH V4 0/2] ndctl: Add daxctl support for the new "famfs"
 mode of devdax
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Alireza_Sanaee?= <alireza.sanaee@huawei.com>
Cc: =?UTF-8?Q?John_Groves?= <John@groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Tue, 20 Jan 2026 17:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260120170135.00003523.alireza.sanaee@huawei.com>
References: 
 <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com> 
 <20260118223548.92823-1-john@jagalactic.com> 
 <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com> 
 <20260120170135.00003523.alireza.sanaee@huawei.com> 
 <aW-1cgruSVTsgV_7@groves.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAAPD1qAFklqVYAWUcuiQ==
Thread-Topic: [PATCH V4 0/2] ndctl: Add daxctl support for the new "famfs"
 mode of devdax
X-Wm-Sent-Timestamp: 1768928735
Message-ID: <0100019bdc5e7afc-e41beaa8-85aa-4572-9512-5a44440993e5-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.20-54.240.11.174
X-Spamd-Result: default: False [0.95 / 15.00];
	TO_EXCESS_QP(1.20)[];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[jagalactic.com:s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq,amazonses.com:s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74699-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[jagalactic.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[john@jagalactic.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jagalactic.com:+,amazonses.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_EXCESS_QP(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,jagalactic.com:email,jagalactic.com:dkim,amazonses.com:dkim,email.amazonses.com:mid]
X-Rspamd-Queue-Id: 36D934A618
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/01/20 05:01PM, Alireza Sanaee wrote:=0D=0A> On Sun, 18 Jan 2026 22:=
36:02 +0000=0D=0A> John Groves <john@jagalactic.com> wrote:=0D=0A>=20=0D=0A=
> Hi John,=0D=0A>=20=0D=0A> What's the base commit for this set=3F I seem=
 not be able to apply on ndctl master. Maybe I am missing something.=0D=0A=
=0D=0AThis series is based on the v83 tag, which is sha 4f7a1c6.=0D=0A=0D=
=0AJohn=0D=0A=0D=0A

