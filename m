Return-Path: <linux-fsdevel+bounces-74506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC63D3B39A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C4E23001805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED9310771;
	Mon, 19 Jan 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG6/OT3X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXfozt9r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG6/OT3X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXfozt9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B8314A95
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842858; cv=none; b=CrKd+6deYBuB3SZWs+Rxyw5K6kWm7oXs7DGRGsY8RYTEFOy7EQq1C+26+vspvMsBBRRQ+/0XoFkIKU9bw3+58zcmbAZxKLjFeBS/HyP6jy9r/twMmuaFa/ZT1vzsMD46+2WBqozcaXRMeKQFWzR6izSBkNokj6KwBKp6+jzu4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842858; c=relaxed/simple;
	bh=PY1JGOUH/vV2+WUmIeQdColPRV1d2yOxwQSz1pB6oX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC++yfUni/KyfC4bqFmIfxdtErqtXdQTxJQIBoqRsNOEp96wIW4AL04fJuH37v3Fsp99CCsajf/W1PZLgQBjv4tdHeh0pi469qTun+Desy+1WeCOmz04/z/qUW9hQD2jc7GuuM4c7AUfj+ah/aM+S1dCfUeALvS4viRWyUuTlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG6/OT3X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yXfozt9r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG6/OT3X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yXfozt9r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA8115BCC3;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768842848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WqupJHG99/Afd8YrHdVJKixb6NugYuSOb1YobfnM3Go=;
	b=gG6/OT3Xv1Eheyk8Zg/i12vDGoMc39Nu45xvVT+LJ/Upr7sqWOoL6mTgb4NfsZrimsCLJU
	Azkz3CPwK/24Bh+K429grEwQ580dJRmEPj27tyqaa6WnFEVsUElZ18jwnakc8yJdgX12wA
	zTIm0BmCRsYdsdUFele0Oeh1Wt0+MYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768842848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WqupJHG99/Afd8YrHdVJKixb6NugYuSOb1YobfnM3Go=;
	b=yXfozt9rThmxQKhPx5i95oq6aPRKxi3aiBNmYKo8uEeacw9QvillXc+qmgrKWlw6j2EnVD
	9lZ1HXmyWJPV/BAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768842848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WqupJHG99/Afd8YrHdVJKixb6NugYuSOb1YobfnM3Go=;
	b=gG6/OT3Xv1Eheyk8Zg/i12vDGoMc39Nu45xvVT+LJ/Upr7sqWOoL6mTgb4NfsZrimsCLJU
	Azkz3CPwK/24Bh+K429grEwQ580dJRmEPj27tyqaa6WnFEVsUElZ18jwnakc8yJdgX12wA
	zTIm0BmCRsYdsdUFele0Oeh1Wt0+MYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768842848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WqupJHG99/Afd8YrHdVJKixb6NugYuSOb1YobfnM3Go=;
	b=yXfozt9rThmxQKhPx5i95oq6aPRKxi3aiBNmYKo8uEeacw9QvillXc+qmgrKWlw6j2EnVD
	9lZ1HXmyWJPV/BAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA2F73EA65;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NypeLWBmbmmCJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 17:14:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 509A1A09DA; Mon, 19 Jan 2026 18:14:08 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] fsnotify: Independent inode tracking
Date: Mon, 19 Jan 2026 18:13:37 +0100
Message-ID: <20260119161505.26187-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=632; i=jack@suse.cz; h=from:subject:message-id; bh=PY1JGOUH/vV2+WUmIeQdColPRV1d2yOxwQSz1pB6oX8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpbmZAz+MsRyR7uwsfsnSR02/8hVgFhtbQr/lKJ C5xpH0QzTuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW5mQAAKCRCcnaoHP2RA 2Uq8CAChoCLuUPKWTlHnwF+cYnj94lCED597/BipTFtIQeonmEAb0ENY8UzseKu0qJ+Pp16D7Mo vyxamW5zQLSk4Zdk9SLfDT5bkSj/6oiID3B2SwdpcPzv09ZuSxmz+eft3yv1n3sUAePhVWK6rxj stNv4lflikf2ONk6eMl03N0VzH4yxgKTVyynuJnsILxkB0p9xqNY8LUuk7ZYyWKFgJscb5ujAWs 9l9kl3aD9UN5ch3N3FhjEpL/9fwafL4SL8Xo8pX7lgvCu6eivMsSTfx2BQMhAnbnTsPNGyKEaq7 0MDWGG82dq8KPyyg9BtXQWyv8hqum3qfczgO0Bzzuo3TYRZh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO

Hello!

This patch set implements independent tracking of inodes that have any
notification marks attached through a linked list of mark connectors used for
inodes. We then use this list to destroy all inode marks for a superblock
during unmount instead of iterating all inodes on a superblock. With this more
efficient way of destroying all inode marks we can move this destruction
earlier in generic_shutdown_super() before dcache (and sb->s_root in
particular) is pruned which fixes races between fsnotify events encoding
handles and accessing sb->s_root after generic_shutdown_super() has freed them.

								Honza

