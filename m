Return-Path: <linux-fsdevel+bounces-75628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJYlDArxeGkCuAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:08:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7198323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 787703008C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A53624B0;
	Tue, 27 Jan 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klgPpEz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8831AAAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533569; cv=pass; b=Rv5RqZxnr6iR2shhYZokn/YWHNesj7VMU3Ty9KVbfvuIKcrKoKmsO5hmozAe7IvLFlgHkcgpBOLlN+uwM7hoiKwwmolbJZc8ppNoKrrje90ZiNqOpOPNndTsr5KY3N9aRy7ncQSUwR9CEhnQdU5ff5hGW87/o1OU85uIx3x0JMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533569; c=relaxed/simple;
	bh=Ne/wDZWmTQX4jToKMN2jIfmNenhw1d9nLN5gcOd+mgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IPhrDxJnZiNE/vjBOT3BHBurTIqhLYWBzsN3ZkeAL0BMU1/C1a9jF4taKCKZT9s5k3/JVTDJOSGOEiFViQdfGfo9G3Q/ZBZXrrxDSSP32C5yI6OAKvw8JCEqFEjP/CiPATraOsilseBbyVMAenp1FIn8Xrxafpu942kh4NX5U2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klgPpEz1; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso5909963e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 09:06:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769533566; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJhVz+IZa9UOUA3QwnhxHiIAczPm6CwMPOU6MUG056jOGTPCza3syDTZbFwBI65Egl
         E7NUklKLPgDkEpadeIzfZzXkvmj9HZ9bIT3LkNEXtZkF7JStCJi4UeCQ3INrDjlqWzwl
         AxSuv2kqKK7A1sgO3YgO7CDZGuHKVh480TsBqrGV93DNRe9Y44B8o4XiphDDPfoSa4WK
         IjnGkEMAfT9sYhkID0w0e8U55ZR2Oj1Zb05EVia4lvo/bEiyQSc7GiHC51qzGxOPGvaa
         TiFGBg536Y1lNR52sQkO6iFRb5cPBx6dIsYwdypZhKfilGmJsW0p2Wl4UUJD30qYeSl4
         eWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=UMwhzOE1wbM4sSF0De7N0bi31NVlWX3cs7L/RQLoT+Q=;
        fh=7nuqU2ZPrFCuuTyonxH8fO7caSJxJpict7IdICBnc0k=;
        b=EANsbw2nfELYz7nx3to9SyrRblXo9DVnQk96uq2rQUlG8wTkJp8M9wgGmrxE7oj95f
         QrVBUGbdBqkHntAfOqHb5dIHFdHCKVZumslnJy1UfVRdqfnT2KZLHZLJKpXjYyinr7LZ
         Jt5BBB59SiHuUmbIbDU0f5VimrLZagDBNCu3NTHLycL0wISLpd/knZenfhhMyujKMAMk
         gqWtfuLifniNL1TQL4pX7gvKAMxUyDb+DStuJM4Df/YP8xMPddrXAsysSYifUcgoMaUO
         jrilh7Et8QIQ70TTtspPZxu4jp9feEsnVaajt9ePlfamsChy9reUl6LbgFU2YFSEYNw9
         feTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769533566; x=1770138366; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMwhzOE1wbM4sSF0De7N0bi31NVlWX3cs7L/RQLoT+Q=;
        b=klgPpEz1crL7VmvNgakbchw0RPw0N0IMor7nXAAErUqK6hE2uc2nmkWj3s8EVYBgbm
         LK0IJKR+qCkTkEzuw5omirES42UHzZ0dWHBBXSVlKrOWqAOHfvkLq8K0gcrA7qYsPCfI
         xLgDfM72kmhHF03aBTu0RcWzKg9DZw31oig9DxExRdj2GDAoDIiswTsVlcq01CMRc/7K
         gHau+TcXNZn8KnnuCGnfcuN7oLTmgk53TFLEUFXbJ6kn1cQoeLtsam/cXo6RORjWqIUm
         gXZdB3Yl5Ji5p0JYKchuFYl7U6SFJ286JVwMA6ihYVuD2YkTxRKj+Qc14Ov+Yhtlit4i
         fcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769533566; x=1770138366;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMwhzOE1wbM4sSF0De7N0bi31NVlWX3cs7L/RQLoT+Q=;
        b=EUoLW/SO/KLMCM04PGPwz6+/XxWpuwHQkt7nAhGK7QFtV+RHKrvqpqIcWSfEYMJqqr
         jo2XUKG6qcDA8Sma0mAQuo/pXzSf7T1oLiI16SKW/Huv0vCdiT62MQEjH3mxbHoEZSTv
         dC2POQ+ShnbYJSTQUNRtisqyhod+7mRQC82sAY9h17ZoX3QPYKwKAOjGUPqi3MW2LsQs
         XG7b6DdPAx0u/shKmuIBrgx78F06Rzaz+XfzkLjgohdac9x2Dkc/SgNDTqJ4L96G52oF
         7bYw4KjWDj22oXnEJdn67Y/LQacvw29C/e4sQ0uXolOJfQ1QkNbI6c+kdFqbWeMl8QSK
         QllQ==
X-Forwarded-Encrypted: i=1; AJvYcCULv/ogZ8uuQw6GqY+D4FuyoSwSiPJsAJ6HcnjVGLcR0aVqO4VUw41/rkDYvE9LRX4RYsAb+PetOkIga5xy@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBENcACne7ZISS+SiqsMQaLK46bFZ/yi5csqBWTc+k+JZmLHy
	os445zHjR4xzW7sbvcghne3WzeQRxYaLt/sGc6i3pw9uHlYlMTMJtuAqGYQWfEi59uMrxUbZ4je
	WCYFr3KDfaxiDXCf2JrF7gn6m+9MS4le/RhQqUIw=
X-Gm-Gg: AZuq6aKuTfYQ5W9VDJZbm1pu/Gno3e8wYlmHe6fFOXnY6NrzriSaKHsUUebC0pVacEX
	7qj9hrCc//W5ybRpSX5CMSjwYNHwBTq+uoc4NRrtKTJZzNVaZKj38/tHwRpm8n7Ycb6YcxFCv9B
	SYyiokXvW7+BD9cJST1KqL1BdTL/Xale3YaE8dKd9Ti7mNLz05PprhACze6XDQczvG53MoXPSnl
	Ov5s7X0p4MvRIQCiF1At44YU+FGouW5lKNag4mfUt2v702mlAhICdN9X1LiRTR7Qqju/Xmg7/fW
	FTS5SnI84vbFh5vR6cUsHCVI9OOI
X-Received: by 2002:ac2:4e08:0:b0:59d:f797:31d8 with SMTP id
 2adb3069b0e04-59e04016dcfmr1192049e87.12.1769533565431; Tue, 27 Jan 2026
 09:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: slandden@gmail.com
From: Shawn Landden <slandden@gmail.com>
Date: Tue, 27 Jan 2026 09:05:52 -0800
X-Gm-Features: AZwV_QguYYziG7-x0QsTu5nT9Dxg0H5cBMP_LYdpt6SWLH0EqPUcG8pqpXDdfTk
Message-ID: <CA+49okq0ouJvAx0=txR_gyNKtZj55p3Zw4MB8jXZsGr4bEGjRA@mail.gmail.com>
Subject: isofs: support full length file names (255 instead of 253)
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75628-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slandden@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	HAS_REPLYTO(0.00)[slandden@gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 41C7198323
X-Rspamd-Action: no action

commit 561453fdcf0dd8f4402f14867bf5bd961cb1704d (HEAD -> master)
Author: shawn landden <slandden@gmail.com>
Date:   Thu Jan 15 21:44:11 2026 +0000

    isofs: support full length file names (255 instead of 253)
    Linux file names can be up to 255 characters in
    length (256 characters with the NUL), but the code
    here only supports 253 characters.

    I tested a different version of this patch a few
    years back when I fumbled across this bug, but
    this version has not been tested.

    As mentioned by Jan Kara, the Rockridge standard
    to ECMA119/ISO9660 has no limit of file name length,
    but this limits file names to the traditional 255
    NAME_MAX value.

    Signed-off-by: Shawn Landden <slandden@gmail.com>

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 576498245b9d..094778d77974 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -271,7 +271,7 @@ int get_rock_ridge_filename(struct iso_directory_record *de,
                                break;
                        }
                        len = rr->len - 5;
-                       if (retnamlen + len >= 254) {
+                       if (retnamlen + len > NAME_MAX) {
                                truncate = 1;
                                break;
                        }

