Return-Path: <linux-fsdevel+bounces-5590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD280DF0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3436A1C2157F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5156474;
	Mon, 11 Dec 2023 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5x1XJVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33CBEB;
	Mon, 11 Dec 2023 14:59:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c67c1ad5beso4527684a12.1;
        Mon, 11 Dec 2023 14:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335593; x=1702940393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx0oVOyQzMGPGluxnOFD9OMhvfFdqxoPJ5MJSTZV8G4=;
        b=E5x1XJVAyVz+ROCoPxStu4U8tHX82+GO1VsHE63vwAxxTivIrDzdKD5XUxCyUHP0mr
         QC6XzrvQ+g8SurXcgc407BGNvDc+g9uqk7ireTauBTS1y+camkk+cnrI+Q7QzNVu4i71
         ncQqyj1Hai/3Z59helNpg9OXuPsIg7Qtq+DUi3/z7Yd+8yzQP8y4LAHb7HoUT+gEVNZw
         ZEJ+fMH1fhnnl52NiLrh3OrAbm2tZ9d/4ed39T4rIgGc42sw7UaJyic35DZT4jh+BkFN
         BRjhV1qpwaRAB6n9fE4SrddWZO4Wd9jYSjIAdndQmU2UMP2L97jo5ySTTIa55S0cwJaN
         38mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335593; x=1702940393;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lx0oVOyQzMGPGluxnOFD9OMhvfFdqxoPJ5MJSTZV8G4=;
        b=lxThh7Wmt6g5s0Hw4/6cz4q/t0eawufsjKufniYjVnGYPOPXNs5LhPinO+Iaq/Kwer
         84DC/ZYL4qVhxgsDhAjKIZjV+6tL1+xqDkFxlRdewBPfBGKhjrImlfbCC2cJyECSIN7A
         r+4z5/IEtIQhe1Q4B5Ra/grm4nSlDcB5xYdj7Mm/2N9hWk4SwBN8XJJwe/taL3HBfQOo
         Wacz+8+IZP442Mrop217So2Ew8vGPK8/FfNgB3V/Bbn2Eq9D7Q6tXHH7atuHGHVgN07R
         0o6xMVl/QhmPSdEaxDhwQ3ZB7PxoQ9oJ5KEibjPixPgRgyxqvC2rDdlZb4gDAYQU35o4
         B07g==
X-Gm-Message-State: AOJu0YzMzcro7O7uTMWJFjJeiCrTPg3y5hC0o0Nq0ZIu5jV24pPryEqT
	dBpz4xv6qSJ4hFSUeDVy5e0=
X-Google-Smtp-Source: AGHT+IGNgztQrzFshOx4WZ/2YmzuwTKg8ccuIe19QSQCGTPHHmZm1VOTX/2e7VaGhdz2jBe7uZIZrQ==
X-Received: by 2002:a17:90b:11c1:b0:286:6cd8:ef0b with SMTP id gv1-20020a17090b11c100b002866cd8ef0bmr5907646pjb.35.1702335593186;
        Mon, 11 Dec 2023 14:59:53 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id dj14-20020a17090ad2ce00b00286e8fe03c1sm7675863pjb.22.2023.12.11.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:59:52 -0800 (PST)
Date: Mon, 11 Dec 2023 14:59:51 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 paul@paul-moore.com, 
 brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 keescook@chromium.org, 
 kernel-team@meta.com, 
 sargun@sargun.me
Message-ID: <657794676caae_edaa20844@john.notmuch>
In-Reply-To: <20231207185443.2297160-8-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-8-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 7/8] selftests/bpf: add BPF object loading tests
 with explicit token passing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Add a few tests that attempt to load BPF object containing privileged
> map, program, and the one requiring mandatory BTF uploading into the
> kernel (to validate token FD propagation to BPF_BTF_LOAD command).
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

