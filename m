Return-Path: <linux-fsdevel+bounces-76696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEY4M5O+iWneBQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 12:01:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18310E7CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE9343035270
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5336999D;
	Mon,  9 Feb 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utRBcfdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551336997D;
	Mon,  9 Feb 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634722; cv=none; b=J8ccm8IwuBAvFsTkEmGEfD2Ozw175w8R+qj79Xjb8ONIN/wzQZAw6YXgS7gv1MRCX1RRo3maUP5HWCpsNqRmMfNmnrfINBbK7JZfYn7quQMg8x/vrOJsueCscsRKUQu+jpro1I6LqYOxBqIqKMJHhEmFyPVqC68xieWb4E0FfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634722; c=relaxed/simple;
	bh=h4GEDWe6uuyTQA1rzNq+PrtcqbCscpqHvhtCUOumA0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVIaURAEEHFbA/SAXQvRgAq9XStiIlI8h6KWvrIHm/m7YxrnetAtF1tF3JsKk5MHfZF0sMvUi/YFZTXmH24c/UVvEpxWem+aT/EDsuFZoVfluBvC9tzo/6gVbiLfqp1QLBMcwKLUksq41myH7rH76uPvB9K3yOLuAbb0EY98Wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utRBcfdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0277C116C6;
	Mon,  9 Feb 2026 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770634722;
	bh=h4GEDWe6uuyTQA1rzNq+PrtcqbCscpqHvhtCUOumA0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=utRBcfdgQb/Vh0ugZwAdpOO5VgCTumAcb6d4miCD6RJ7VPECh0BhuQl/YXk5y2Kpu
	 l5U4KdSWTnhVVFNBCz9dU2CKqpcwu6D8LcxRm/IjCe+0f+Bqh4HOukfWD7CLUxcaZE
	 lDWhu5U4V79a6H4lU+DP30sAgfSboPFG4dZg8VI9SXsckxUU2TsfQ+l5bQWvdtqn+g
	 Jd/Cl+YQXBYChr6qDflqJqtKucATI5q5q70WvxEwi4B4XJGEp19nNNpHCGZUAt+5p8
	 +L+umfv3296UkHssiy74eKSHmmGMtReJG1M9n09B9iNRUtTbuZpI093NsKit2sue6W
	 zcdjFtGB+JFgw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>, Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, hch@infradead.org, jlbec@evilplan.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
 kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
In-Reply-To: <aYTWbElo_U_neJZi@deathstar>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
Date: Mon, 09 Feb 2026 11:58:22 +0100
Message-ID: <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,debian.org];
	TAGGED_FROM(0.00)[bounces-76696-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,gmail.com,wbinvd.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,t14s.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 3D18310E7CF
X-Rspamd-Action: no action

"Matthew Wood" <thepacketgeek@gmail.com> writes:

> Hi Breno and Andreas,
>
> I'm in favor of this RFC as I think the current flow of needing to
> create the cmdline0 dir in the netconsole configfs (when DYNAMIC config
> is enabled) prior to modifying the values is not ideal.
>
> I think there are good points shared about sysfs vs. configfs being used
> for the cmdline target modification and wanted to add my thoughts.

Thanks, I appreciate it.

>
> On Fri, Dec 05, 2025 at 08:29:04PM +0100, Andreas Hindborg wrote:
>> "Breno Leitao" <leitao@debian.org> writes:
>>
>> > Hello Andreas,
>> >
>> > On Fri, Dec 05, 2025 at 06:35:12PM +0100, Andreas Hindborg wrote:
>> >> "Breno Leitao" <leitao@debian.org> writes:
>> >>
>> >> > This series introduces a new kernel-space item registration API for configfs
>> >> > to enable subsystems to programmatically create configfs items whose lifecycle
>> >> > is controlled by the kernel rather than userspace.
>> >> >
>> >> > Currently, configfs items can only be created via userspace mkdir operations,
>> >> > which limits their utility for kernel-driven configuration scenarios such as
>> >> > boot parameters or hardware auto-detection.
>> >>
>> >> I thought sysfs would handle this kind of scenarios?
>> >
>> > sysfs has gaps as well, to manage user-create items.
>> >
>> > Netconsole has two types of "targets". Those created dynamically
>> > (CONFIG_NETCONSOLE_DYNAMIC), where user can create and remove as many
>> > targets as it needs, and netconsole would send to it. This fits very
>> > well in configfs.
>> >
>> >   mkdir /sys/kernel/config/netconsole/mytarget
>> >   .. manage the target using configfs items/files
>> >   rmdir /sys/kernel/config/netconsole/mytarget
>> >
>> > This is a perfect fit for configfs, and I don't see how it would work
>> > with sysfs.
>>
>> Right, these go in configfs, we are on the same page about that.
>>
>> >
>> > On top of that, there are netconsole targets that are coming from
>> > cmdline (basically to cover while userspace is not initialized). These
>> > are coming from cmdline and its life-cycle is managed by the kernel.
>> > I.e, the kernel knows about them, and wants to expose it to the user
>> > (which can even disable them later). This is the problem I this patch
>> > addresses (exposing them easily).
>>
>> I wonder if these entries could be exposed via sysfs? You could create
>> the same directory structure as you have in configfs for the user
>> created devices, so the only thing user space has to do is to point at a
>> different directory.
>>
> Although technically feasible, this approach leads to an inconsistent
> and confusing management of the netconsole targets. A configfs path for
> user-space created targets and a sysfs path for the cmdline initiated
> target that can also be modified from userspace (e.g. to update
> remote_ip or userdata fields).
>
> I think Breno's approach sets up for the most intuitive user experience.
> The cmdline config for netconsole is also user-provided, so it seems
> like it should behave as a pre-populated configfs target that happens to
> pass from cmdline through netconsole module init to the current configfs
> interface. The initial values are not determined by the kernel itself.

How about using default groups for this, would that not be feasible?

While I understand the use case for this patch, I don't think it is a
good solution. It changes the fundamental assumptions of configfs. So if
we are going to go down this route I would like more people to review
the patches and weigh in with their opinion.

Perhaps we should discuss this at a venue where we can get some more
people together? LPC or LSF maybe?


Best regards,
Andreas Hindborg



