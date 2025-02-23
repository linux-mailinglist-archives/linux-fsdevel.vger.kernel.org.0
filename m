Return-Path: <linux-fsdevel+bounces-42356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4609BA40D7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 09:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353F73B0403
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31001FF7D2;
	Sun, 23 Feb 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tK2mXp5W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6FKQwyRr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tK2mXp5W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6FKQwyRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7D1FC0EE
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300795; cv=none; b=aqjc+X5br07CIZ71fzduYoc8jxANcKMkvlkadYTcDRfQC/bIlH6uCCI54KidIOmCeYRQyo/Cl9/ZBrdRI5B2zeKlU5MQhS/SqpDVnNEF6+UPcVP3yQsAw8hdkARZM7GsFUmgq+YLoMp91XFezE841w+XPxvyUJSG/sZwur+eNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300795; c=relaxed/simple;
	bh=kXabbZuH8nmvuZUugWPRsrzpUzlR5tkZghkl9EnKBLQ=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=gPTcjFItXRzjY3/GQ3a3wLeH/xA/M7KO0kdLUB9sOVYIv3FYD92NTAgl9iFbWnkmDSH9/OUdmnRtRzVf6T0+E/OuvE3o/xDhgKWJGrbKTR8mGUWgg3rv15x32CUeQg9tYEkb6OoZKjUucwDTdQImvM+/VYq5BbS5001ne6bcVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tK2mXp5W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6FKQwyRr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tK2mXp5W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6FKQwyRr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92F0C1F383;
	Sun, 23 Feb 2025 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740300791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Z2Aurb0tFrAght4VDTSh5xS+Dxx12mfI5R7RQ6P2LuM=;
	b=tK2mXp5WQhS8hglQ8zv/5LoaER1lb8K5+GoCMyWq4au1BsMY8fmlFjSP+5JeK5dG58fpXU
	GByXpHPSuKMr4YRnSq6uuEZXgSSXvNqtwMgl53yO8Musllgav6buhaM31pE0TSTLYvJP7Q
	XrkOIEVmTHqDDLMRY3v1TAyAoN575NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740300791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Z2Aurb0tFrAght4VDTSh5xS+Dxx12mfI5R7RQ6P2LuM=;
	b=6FKQwyRrHfhAENwuKYDKWYzpRwJcloUwGZNVaRRiwDQQLzNLaT70+uOe1rPfaAe1rT1yZ6
	PD2cyVxYeb8K06Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740300791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Z2Aurb0tFrAght4VDTSh5xS+Dxx12mfI5R7RQ6P2LuM=;
	b=tK2mXp5WQhS8hglQ8zv/5LoaER1lb8K5+GoCMyWq4au1BsMY8fmlFjSP+5JeK5dG58fpXU
	GByXpHPSuKMr4YRnSq6uuEZXgSSXvNqtwMgl53yO8Musllgav6buhaM31pE0TSTLYvJP7Q
	XrkOIEVmTHqDDLMRY3v1TAyAoN575NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740300791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Z2Aurb0tFrAght4VDTSh5xS+Dxx12mfI5R7RQ6P2LuM=;
	b=6FKQwyRrHfhAENwuKYDKWYzpRwJcloUwGZNVaRRiwDQQLzNLaT70+uOe1rPfaAe1rT1yZ6
	PD2cyVxYeb8K06Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25C5F13A39;
	Sun, 23 Feb 2025 08:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DZS8BffhumfUewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 23 Feb 2025 08:53:11 +0000
Date: Sun, 23 Feb 2025 09:53:10 +0100
Message-ID: <874j0lvy89.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: regressions@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

[ resent due to a wrong address for regression reporting, sorry! ]

Hi,

we received a bug report showing the regression on 6.13.1 kernel
against 6.13.0.  The symptom is that Chrome and VSCode stopped working
with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
  https://bugzilla.suse.com/show_bug.cgi?id=1236943

Quoting from there:
"""
I use the latest TW on Gnome with a 4K display and 150%
scaling. Everything has been working fine, but recently both Chrome
and VSCode (installed from official non-openSUSE channels) stopped
working with Scaling.
....
I am using VSCode with:
`--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
"""

Surprisingly, the bisection pointed to the backport of the commit
b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
to iterate simple_offset directories").

Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
fix the issue.  Also, the reporter verified that the latest 6.14-rc
release is still affected, too.

For now I have no concrete idea how the patch could break the behavior
of a graphical application like the above.  Let us know if you need
something for debugging.  (Or at easiest, join to the bugzilla entry
and ask there; or open another bug report at whatever you like.)

BTW, I'll be traveling tomorrow, so my reply will be delayed.


thanks,

Takashi

#regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
#regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943

