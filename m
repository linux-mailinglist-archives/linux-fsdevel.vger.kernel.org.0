Return-Path: <linux-fsdevel+bounces-75157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFPvA8uXcmnBmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:34:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBF6DCAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E12E3008D56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744873B8BD8;
	Thu, 22 Jan 2026 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE9f9QXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D58314A6C
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117633; cv=pass; b=b2WP6wN1m47Uy8PB6ZR+vFik+RNOxQtcKwb7wbJuTPP8wmzqH7P5oOKxW7XvzP3L7CnFf2n/bkTheJRbHsktOJ3Wc5L7MPJzg9dpP3GqZaKTeViGC+0ZrUUsJNoaEk1YKOaCZ7LR6XeuPuJ/0jPKfQndmuJEpKC4e820428EHZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117633; c=relaxed/simple;
	bh=6TQk5VBP3Apn9oSuY1koRPknOD+h/oo064BNRERmo+s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uv0n4ai0DR5nlZX/s0VMHlSAGIqP8QgfZ5BCS+XIeRUiKCKz7m6BACCN21qWFKoLVDBUdhWz75OVX8fNf0S5dHY9oJuprI8hx82UcTswlMnjWPKD14WwIHnmmIiB0tt3JP5FxvE5CurPD6TMNsJ5n8TcO1MNO/+3vLjfSx8gNck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE9f9QXZ; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-382fceabddfso11773721fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 13:33:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769117627; cv=none;
        d=google.com; s=arc-20240605;
        b=dx9f4UrjgtebRoxHaTgultkHr5H0TX+semt1L+Ccntud6VLqmOv/mPb0koA6BKQMDU
         iXgK0VV/2xdswHFStcj9UjPjIDvAzErvZIWue76RTHYgUIjSBVuAeOXr3NvrR0jCKrHA
         hzWSo1x6Mze3mudAT+f6UGEFioxisV1sUXmWs9jjpfzeksZqvemiSWsJfl/Xl7c8CfJV
         7GoZ/UHnx+Fl5ahneRDxCj/OpsDDB7SSzsOGrat4LKOtXWsx9P5GIiEb/+x5B6NBVttr
         8vgZ5dHRv7iIqjhfXLFRK1Fn1DRxqET3XtIrdY0AwcKokyOlsKeVtC4gbZySrC5EueuP
         Kkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=g7oRgy/tk8RRmWcGe/LhPVXYWjTBgg6SZHZHkjSsXlM=;
        fh=b7jPGPHtQ2uHOv+IAIWl6DqU41dAJIJ79mke9g5dDTs=;
        b=hrTBxadVNzRA4ESC4S7dEJa1BneqWkpqzDzYnGTlnfqVDW4QbBN3IGtBtXYxyE4Upu
         xP18gY5YVBF5h2Lver8zza4Rq5v7T3cBvqcitl7ErMVrCAt6BuvJAq0Mu+qaOKHtnlj3
         YmBePbBguTVMtjaExKn8bHtyH4BN9MDLvGII9kpkNguXShFUPKxQiNIsIZFSLtEEA95Z
         ApnhN0V4bOcx+JsLrhIheU+kOsj+bdPr4LvATLG+uAFz/eYlEPszyPkTsL9Ryo/CFFSf
         oOgMw+Nt3YtPtSSxvzpPOQo6deWFcKIzaTOu1k3mLPi+yrR02Fwnp9NpEFyqnD4pfbuj
         Wz5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769117627; x=1769722427; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7oRgy/tk8RRmWcGe/LhPVXYWjTBgg6SZHZHkjSsXlM=;
        b=JE9f9QXZYIY3NFO2s6u3WeBWaFXJ/feQ+8hiiJigyuIIAVEqd1+UuOkoiQ/NTsRKzP
         gP3To2oAMGgSYukZZYTOgvVkTm3rXbEaVja5NKdVXTqePTFD3qIl33mUrf5tkcTSnm0I
         w2jykasPv4yA1j8qgArtWXIOzZh1wD9O5mitmVbTMk+bsLTZA2oZ1G5Ndrkibz5pbp8Z
         6H6OJ7/1/VH3kgvYutou7PckwPwvIwBiPOSywgjuO59QYiOB+C6kLb8RtE4F+2ZRqYTD
         jjqz2cg/uAwc8gslbXaGLBUMbFPuv+fpfzpnBUnKbJKpW9x6wqZ3gx7xvz5jBNAWJ3wN
         AYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117627; x=1769722427;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7oRgy/tk8RRmWcGe/LhPVXYWjTBgg6SZHZHkjSsXlM=;
        b=WxS64mrEjPRVjyXNrxKjnoZUzfbR0i7rz2/yyeR8khZIbxXO1E470FBThjeCf5ZxeL
         mgpP4qObDUJ7Mfdc8mOuaSQpPcwmFIdNIGVtzhRBVDZWVa7M9XH5MjM6JzfX33WSnpjD
         Wl3Syfnb1dViFdP926x/rMb+YhL2PseZTJAnv6vL4Jyd678hBQiadNfjrxuduKkjCjT1
         AfIyrrm/ViYB0o3QdawKJk1mumJbMY0Mk2Cc7NayIrYEsrq5XGXp6en9Q4ydYSjNoV+V
         e5MfMPk37L1Dpw30kWZR5dNA013ErNvZ9M+IhLjuuVCnINHbea2mEZtQj9NLc8/1YJYF
         SNKw==
X-Forwarded-Encrypted: i=1; AJvYcCWDn406iu6auxxDwSGaoMfh5cG82DmDF3wRoSwbnnTQvZ3eveB2jtRta+jxBg9Egvf9gOodoUPSxpBmsWSh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52xc1rZnGRgjj0nCZsy2MmZB1apIHwMvwTU3/e2aSN+9Pondj
	VvoWneEQrHn4ngooN25a7D2+cLjI4rtnBr+y10Zmslpb0wYx/ptP7oC4eM1awnDL1tEAx2kUA3w
	81qKquIbjgGexEWp+kar7x3mNNfu/3hzFnq+4LEs=
X-Gm-Gg: AZuq6aKfLcm+eKaORlbTmLmXJM7/0tj5omnitqm/LVTA54JmuXsRMp4xbe9eWUyhgxU
	mq4OP1B/3Rp6CDwiRbWvEKKwUofUP9QXa0w4SvLJ4MOL7AKUz3rLUwwUYSob1nzRtL5hrO0i894
	lS/PvVPxGW7OnhUBIgq/HUM2B/A2FIeAXiUVUiC3Ls4U1kRZj3w7GS/69HhMfRAeuGRmSF4ZtZo
	7HIbxlyrsN89cOPDwCV37h7MyK75fVDtMvYst5NbOY4YOsSR21myFt1E2YNmM13OC756lHnvXSu
	pkqQsZ2vb2AEucWgEltRMwcILZ4V
X-Received: by 2002:a05:651c:1542:b0:385:c6c3:fb8f with SMTP id
 38308e7fff4ca-385da0a823amr1612811fa.30.1769117626612; Thu, 22 Jan 2026
 13:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: slandden@gmail.com
From: Shawn Landden <slandden@gmail.com>
Date: Thu, 22 Jan 2026 13:33:35 -0800
X-Gm-Features: AZwV_Qj6W6gZM7Uhm3aU99yyqApQS3pJK0k_cnhGcOlo5L_VIfxQo3-Sptwzq68
Message-ID: <CA+49okpQYfsg=6AwZ_CGGPSYP0Hed0-+RELwzHg5ovZyXiZFFA@mail.gmail.com>
Subject: isofs: support full length file names
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-75157-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	HAS_REPLYTO(0.00)[slandden@gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9BBF6DCAB
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

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 576498245b9d..094778d77974 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -271,7 +271,7 @@ int get_rock_ridge_filename(struct iso_directory_record *de,
                                break;
                        }
                        len = rr->len - 5;
-                       if (retnamlen + len >= 254) {
+                       if (retnamlen + len > 255) {
                                truncate = 1;
                                break;
                        }

