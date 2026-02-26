Return-Path: <linux-fsdevel+bounces-78623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNWEDPaaoGlVlAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:11:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB581AE38C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED2CE3030D3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7B44BCBB;
	Thu, 26 Feb 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Cc2Ci1Lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DC44BC95;
	Thu, 26 Feb 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132628; cv=pass; b=UgUItdjd4BAxkVqId1fcg34lNELm124HSfgpv/V8JyZEnTCDGC7e8x3vY+Vf3yDHq2WScJNJ1peppJGIQTgmKTxO/aFFpa/S7dYtmBK9gnVvbNaoi7Xh92sQjm+pOIQddCu/50nWOfBUFI7i6bexFciZLCiJsV+QyAhcNfg4FQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132628; c=relaxed/simple;
	bh=uZgGi+v8RiKwWmxGPGm5DNN1Hc0If0PQF1//BOzrBnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQPqt83MuLLwwGH9hQLD55z0a+gnRVOzVV2EgyIS+cOnE4kcI78Q4MXeCXKpux/x2KpSyys3oTXZKhHq4rp1VSGOOw4/89K6LS3rMyARlntqmb542MEDXG+GQVMIyf5kIj0xm/9cDq5xVk37WBJCzZoSEcKD3LGae39rZR73YqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=unknown smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Cc2Ci1Lj; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772132584; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AkPW0V2XVA+ThrMhwJPHq4sxDgQLj1zuOXlGrBRQ13LPu7MOSKxiTMm1axmqivh7Vx+EUpsQb5YWv3UxwLTY3o+W4hXxh6bwjbCTBJMNUR3xY2hx/9xOYTKeBjMfmCAPpvhXb5sLJHDrOqZCxEYxqu47ynIiaAKVgNvQPtOPiYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772132584; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uZgGi+v8RiKwWmxGPGm5DNN1Hc0If0PQF1//BOzrBnE=; 
	b=IErpVE5R2woComG8zSG/1dZVEkmp+bCYlLb9vL3L4OnHBS5gcA5a7pd1E9Efdtzc8VZdFSgPAjVLiHpqlxJg2o5kbrpHBCDchpvf0Sk6QYYM4PaN9qOqwrLuO+AzJ5bDDPCzP3srdZp/cWAI07qQdAvCZdpRu4SZcT7ztCLdkfc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772132584;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=uZgGi+v8RiKwWmxGPGm5DNN1Hc0If0PQF1//BOzrBnE=;
	b=Cc2Ci1LjQWY3/FIKUU/yv6sBS9hEb9l2xrz+4m+mSXGlyRJZj7O3D/+4IMmha5a4
	Ih3hFu1tpD0LB87U7IEvCA4e9nWVsrc+CpCTnkjcTRuFtOewTugrmPL8C/H/O3C1aN4
	9+8DhUPy5ZgJLLBwPNd//mgPjKOOrNHGs3236ocU=
Received: by mx.zohomail.com with SMTPS id 1772132577938770.8398415976353;
	Thu, 26 Feb 2026 11:02:57 -0800 (PST)
Message-ID: <52e1b0fbdbeb8748d197af9d438c137c9db6d284.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v3] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Cc: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	"janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, shardulsb08@gmail.com
Date: Fri, 27 Feb 2026 00:32:52 +0530
In-Reply-To: <54dc9336b514fb10547e27c7d6e1b8b967ee2eda.camel@ibm.com>
References: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
	 <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
	 <ec19e0e22401f2e372dde0aa81061401ebb4bedc.camel@mpiricsoftware.com>
	 <c755dddccae01155eb2aa72d6935a4db939d2cd7.camel@ibm.com>
	 <de25fb7718e226a55dbc012374a22b7b474f0a0a.camel@mpiricsoftware.com>
	 <54dc9336b514fb10547e27c7d6e1b8b967ee2eda.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78623-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url,mpiricsoftware.com:mid,mpiricsoftware.com:dkim]
X-Rspamd-Queue-Id: 8DB581AE38C
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 00:41 +0000, Viacheslav Dubeyko wrote:
> On Sun, 2026-02-15 at 23:27 +0530, Shardul Bankar wrote:
> > On Tue, 2026-02-03 at 23:12 +0000, Viacheslav Dubeyko wrote:
> > > On Tue, 2026-02-03 at 14:28 +0530, Shardul Bankar wrote:
> > > > On Mon, 2026-02-02 at 20:52 +0000, Viacheslav Dubeyko wrote:
> > > > > On Sat, 2026-01-31 at 19:34 +0530, Shardul Bankar wrote:
> As far as I can see, the main logic of working with b-tree map is
> here [1].
> Ideally, we should have a generic method that can be used as here [1]
> as in your
> patch. Could you try to make the search in b-tree map by generic
> method?
>=20
> Thanks,
> Slava.
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfsplus/btree.c#L412

Hi Slava,

I=E2=80=99ve posted the updated v4 series addressing this feedback in a new
thread.

Link:
https://lore.kernel.org/all/20260226091235.927749-1-shardul.b@mpiricsoftwar=
e.com/

Thanks,
Shardul

