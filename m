Return-Path: <linux-fsdevel+bounces-76387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Oy9HHZ2hGkX3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:52:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF4AF17A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287B9303466F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883013A9D83;
	Thu,  5 Feb 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAy8eM2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BED3A9621
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288702; cv=none; b=ugkz5pMuN/MCfzH0TG6LTwrs87ffH3s8+uWsU449VnDBCZMHo+P0C4acqwwU+RiK99P5ItBYJwJ30Y7Bwmp626Ue7HeXxPxl15xBI0D5AtIZYqcA4LXeHK6w+yXUeSeQkI+T9U7nPqAfrD5dY0gpw5Tbbpgq2DEtcQ+1s8hDDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288702; c=relaxed/simple;
	bh=B35AnR3cY3KY+ESrYf5USuFHaMGr2T6vQRpPugNJCz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nlCaILkIjSfmEtNyTMgVESGgEygKsI8ls4/P35jFNYE5xRacknhHmdHO7MU+jKDFtL70j06aEq+mtzGxWBXrWB47AKi4dZe3j7i401ucebTGMepm467kWqTAhqLtelTJMWJ4XioK91nQyl7el1sD5BBsVbaZ4D1oPDnEwf0x27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MAy8eM2R; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so9904985e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770288700; x=1770893500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLcYGJKdfae0UDgu1rmn9Sa9RDtDWULKl4q8DTm9pQw=;
        b=MAy8eM2RokUD5JOpA3xB74t66AdGcTUdWVvPu8Q3XelUjyVlYFjhSfcReYOy9d+E6W
         da5+by2xB71j2T6tJtw921850xMi7vGgTXyOcP0jrAS6DNVFE/+8Z/gz3KLOZzGqPrCP
         rhsKxOp276uKOkpCsWtcovYk9unQzrtKbKB9PjCNLPTd/bSDCIFF2dNEzhrW09lrIFvT
         sOiMtLs/lAxX9eMC28MKlrRjQ6JPEbmMsogOjGusCejlnrj+h6gq2ldn4QSnFCHTL4CH
         AWc0OCyFjpejhpvYf5VSYiqGzLmOHXkgS1nW0mlkqc/cgyobZb64a1zfFJUJjMX8Bi2T
         hesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288700; x=1770893500;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLcYGJKdfae0UDgu1rmn9Sa9RDtDWULKl4q8DTm9pQw=;
        b=nOiitBlvXd9GZafUso7cJOeyo9PDYXbVL8xSnLl8DY40ycZHh0RRAbRuN3r04lWYI/
         re94/9NryHFQFQ3CJeLt1rFwqGAlN8nK6pCFmQPSnOttcKBwp8zAFlR/qry31bGlZ8/w
         UN598mrCacTim/O6yuX/1pKpsqtUHeS8AdisEUjocXq4bRZKqfX04k3yetP5l3WJWSMV
         od8Vng6ZBo8o+sGrLbPGwfuiNA6GkmaIou4CKIxMAQiE8OL6yQz+0Ht3Lt576ALbvN3L
         JwD0Wg77q997Ph/tYI9dODLIJpPQSFT8i4zdflFuwTdjfofMi+lfABO4Cp2F5ImNwtBO
         FbGg==
X-Forwarded-Encrypted: i=1; AJvYcCX/vRLpaC+FHHuOEM/n7Rg29kcec/Qqx7Vh6Y2V8rKF+7Gm+Gq3+hG52msFKefYVwfri/2T09WeVuMOx8SN@vger.kernel.org
X-Gm-Message-State: AOJu0YzzU62b+SO5qOHMdupAYgKEHvLn/xqgx62X/ByIIus/AgaHNQB1
	SQDXcs4Gl5D3FOgf+MQvok9FqLH/PmKxCasWImAt/JdiOmybjSStnhFZjEsZdj9MdrU/pPNzb1S
	FlnOOHlzgz3Umc0k7KQ==
X-Received: from wruy11.prod.google.com ([2002:a5d:620b:0:b0:435:ab2d:c11b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5295:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4830e92c9c2mr72417905e9.5.1770288700302;
 Thu, 05 Feb 2026 02:51:40 -0800 (PST)
Date: Thu, 05 Feb 2026 10:51:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC52hGkC/x3MMQqAMAxA0atIZgttEEWvIg6xjZqlSlpEKN7d4
 viG/wskVuEEU1NA+ZYkZ6xwbQP+oLizkVANaLG3aDuzSgysJqukTJnNgCN5i46CJ6jVpbzJ8x/ n5X0/Pk2sgGEAAAA=
X-Change-Id: 20260204-binder-tristate-729ac021adca
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B35AnR3cY3KY+ESrYf5USuFHaMGr2T6vQRpPugNJCz4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBphHYzrqBA5nhRZndl3zcRt9KeGBwaoiOcP+yXj
 cTUEYoiB1yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaYR2MwAKCRAEWL7uWMY5
 RibnD/9j3gbFLogRDIYf1C8LWr+gvE5LRxKD7sfVosY6d9Ys7W4CkF0F6hQYUFD/U6wpvqT0ok3
 9z7p1wFNskyBGJ+JfAGI6EwJh4sQwT/KKX/W6/Q7IE2wDDj0TsVO9osUl7hdEuh3UXRFikyHQds
 xHKx/OiS3SGuGA1o7RtHGAdWpNnRX4Gt55C9nwh4DKWBnqVO+WpDL8B/y0TZ9DclhJrukb9BRvn
 /QpX/9TRHlU15ACrIGJcOWsm7ebc4w0GWH/zGhg6cqNpJxp1b04N7DzeCnQOZXqYbWyYBYmPWLF
 ZDAqOvBrhXwq7ucLR6QsSL2zZ2k3JaCtpgSMJPOxbCo81CLXSFOyeuTUw5kQSx5n1ral7Jsaifd
 MKcD+a58cZ6rBJjC68hOa8ZRdwzE6OappKRRrJqoPLIvB6scsZ8aDkLXRoI85EVcSQEj1aDPlBQ
 bq55rH0uAncExMiB5V+337URq0Y8dwo2ey6Sr4n/FPOdAhU4tcBu0nt8zvSyhY5w02CGfx+oJv/
 6JWrJUVkzPignN27tKv6rqSXBnTyAy3qw2xb5J7cAW34wJIslC24jarb2/X9T0115pKoM7mzUr/
 HoU7eNSRHawmAT2CoExCy9WOXks3DLTBu+pUXzK0ul6an10l1wEA19p4D/F62pEImvUIFcbbjWD 3qVK2o2UeRXk75Q==
X-Mailer: b4 0.14.2
Message-ID: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
Subject: [PATCH 0/5] Make Rust Binder build as a module
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76387-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,google.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAF4AF17A8
X-Rspamd-Action: no action

Currently Binder only builds as built-in module, but in downstream
Android branches we update the build system to make Rust Binder
buildable as a module. The same situation applies to distros, as there
are many distros that enable Binder for support of apps such as
waydroid, which would benefit from the ability to build Binder as a
module.

Note that although the situation in Android may be temporary - once we
no longer have a C implementation, it makes sense for Rust Binder to be
built-in. But that will both take a while, and in any case, distros
enabling Binder will benefit from it being a module even if Android goes
back to built-in.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (5):
      export file_close_fd and task_work_add
      security: export binder symbols
      mm: export zap_page_range_single and list_lru_add/del
      ipc: export init_ipc_ns and put_ipc_ns
      rust_binder: mark ANDROID_BINDER_IPC_RUST tristate

 drivers/android/Kconfig | 2 +-
 fs/file.c               | 1 +
 ipc/msgutil.c           | 1 +
 ipc/namespace.c         | 1 +
 kernel/task_work.c      | 1 +
 mm/list_lru.c           | 2 ++
 mm/memory.c             | 1 +
 security/security.c     | 4 ++++
 8 files changed, 12 insertions(+), 1 deletion(-)
---
base-commit: 4df29fb5bcebeea28b29386dec18355949512ca1
change-id: 20260204-binder-tristate-729ac021adca

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


