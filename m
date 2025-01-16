Return-Path: <linux-fsdevel+bounces-39350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E692A131E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3703A2481
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 04:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397113B792;
	Thu, 16 Jan 2025 04:06:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145228635F;
	Thu, 16 Jan 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737000368; cv=none; b=p12hKr1Vgdr1ZKgO93HxAezw1oZIzxjwEevujIAiVCYUVWQQ6DvFV9UCrNCxWpfwnQp5CELdMRDKfyTNfq2nna1XnMTEPPlAKkwawqjBFx8TddCZZkCb0kHug5M1n2KRRypm1O7BUB0LZzu8HvOdAzRe01YexoaCG1PbUDv1q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737000368; c=relaxed/simple;
	bh=LoZVtft/fWKMOFlop8+bH7To/FYlJo7ToYmTrf7kD2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5HZIrivVjL6YYLcfA7fgNVPQnUeGYQqe+S2pMwvPTCrL/YU0zNA8SCMpQD6pcHCHRqBdRe6DMdbfD+r7r7Q2hDvsv1yvnqproMeHBtMo4hQlRxEaCeeCgD/KA2GDQpYf8GPar5otaRgNBgFgon5ppQy2DFyQ0fqrs4EavNdw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46769b34cbfso8336421cf.0;
        Wed, 15 Jan 2025 20:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737000366; x=1737605166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3vhwttkfjJiSjvN28GlypdNcRBATGkYOaW9TfWY3F8=;
        b=c2+PWyavDhvwYLZr1EECatmS9MXXB1teKDKN0br6Q/ViYFy+QbN2FYczC1Uj044NW7
         MrEQan0JOkOzvJWj3RVwVEk+VVFXdB17GjlBB5MUj6bHA4Uxxb4wRJ2RWPLAGMRygVlz
         XHpuaVmQ8FfcOcQ2x0naWrDZTktPX/+YryYWMbODsepw5wmnWe2CrfhdCyaNbUyPwBHG
         WThH/hhnKwA5V9FqOVPF0wjnvxVgDp0fpieHlPYzFWZ+ENvXzs7L654eKqv1iwk/OXsU
         FXYH0NEmKoXR2NQ/QkjY9ZPhCbbtszqWVTuel41w9AfPf1s/94zVvAenu1YysRyYIto4
         It+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr/auvDaet0mcHpz2ezH36MIg5cYA19ZrfH+L5T56I3RooSBMeImFyEW2gMetUXizmoB4iMxkZFoHSsN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9XYhKbXnG9kX47gnPHHoO4eHlQp4D3oX4RcEaAhN0s2G3Fc7
	y9J6my4XwzOhfSsgW7wDRev3bg7rjuNQbcHvzi3mArpXK/lL0KbEByeI+M8i
X-Gm-Gg: ASbGncuaKTxlXzP5826HDH6gVOvpG2fgXSSfyfotcs1lIN+wwxjj3mJZ0GGTdXLVESW
	Kfv8mwk/81tYQFsaJKkJeCE0iLmfFDZO3q3Yj95wY+k6/mmZ6FoSAUwR6NfZg4sp6lYQ3l8Q4r2
	0eK73/JB0u8JpOwO2s/IlJn3UWf3+Bk3lMGTTrN+X9aI/AA4/NiXOzBKwEOqPJpIqQwTGOAcvxP
	OBP5CG05g15q7wilGvodrsjyM/vqLRKLGAibQ8kvcdN6oqTjc6Ez763u3l+YB3zD9yc8c8fDO8M
	yemLr6s=
X-Google-Smtp-Source: AGHT+IFMmOdiymzrHyKgzvn0vLDt0NBtS+/h2SXl6K37oWCcpapl1TaVT8AisbD1HbiQdl1ar11ShA==
X-Received: by 2002:a05:622a:1a8d:b0:467:8765:51bb with SMTP id d75a77b69052e-46c7107e0a9mr567207911cf.37.1737000365693;
        Wed, 15 Jan 2025 20:06:05 -0800 (PST)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87340bbesm71336091cf.39.2025.01.15.20.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:06:05 -0800 (PST)
From: Tavian Barnes <tavianator@tavianator.com>
To: linux-fsdevel@vger.kernel.org
Cc: Tavian Barnes <tavianator@tavianator.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: allow interrupting dumps of large anonymous regions
Date: Wed, 15 Jan 2025 23:05:38 -0500
Message-ID: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dump_user_range() supports sparse core dumps by skipping anonymous pages
which have not been modified.  If get_dump_page() returns NULL, the page
is skipped rather than written to the core dump with dump_emit_page().

Sadly, dump_emit_page() contains the only check for dump_interrupted(),
so when dumping a very large sparse region, the core dump becomes
effectively uninterruptible.  This can be observed with the following
test program:

    #include <stdlib.h>
    #include <stdio.h>
    #include <sys/mman.h>

    int main(void) {
        char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
                MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
        printf("%p %m\n", mem);
        if (mem != MAP_FAILED) {
                mem[0] = 1;
        }
        abort();
    }

The program allocates 1 TiB of anonymous memory, touches one page of it,
and aborts.  During the core dump, SIGKILL has no effect.  It takes
about 30 seconds to finish the dump, burning 100% CPU.

This issue naturally arises with things like Address Sanitizer, which
allocate a large sparse region of virtual address space for their shadow
memory.

Fix it by checking dump_interrupted() explicitly in dump_user_pages().

Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 fs/coredump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index d48edb37bc35..fd29d3f15f1e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -950,6 +950,10 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 			}
 		} else {
 			dump_skip(cprm, PAGE_SIZE);
+			if (dump_interrupted()) {
+				dump_page_free(dump_page);
+				return 0;
+			}
 		}
 		cond_resched();
 	}
-- 
2.48.1


