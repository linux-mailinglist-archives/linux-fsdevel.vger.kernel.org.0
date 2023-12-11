Return-Path: <linux-fsdevel+bounces-5585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE280DD6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917B1281D31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0954FB4;
	Mon, 11 Dec 2023 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiZO2+tg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C05DB;
	Mon, 11 Dec 2023 13:44:12 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce9e897aeaso4261615b3a.2;
        Mon, 11 Dec 2023 13:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702331052; x=1702935852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7imiHd03OeHfJqIYuOPkDI+twRgYtwGYnCJrI3xJS8=;
        b=EiZO2+tgoXFuj04IBU4brCZTyaGhsHBb3IkKe4ItBRxunGYynvMp2iq6pq35D/FuJB
         o93CLmDsCmBpi1kAenvoVtR/VBauS3L4VynD49HldaxtwU+x28D7CsQw0B6CV9tYT/Ez
         85ucDr5UM9+xJnI5tvV+elVu/JGBWX0DgfT7V3Pvy1im8ykbP9auv9/gzAaR71S0JOr7
         S2Utf7lZdrrWRSvoou2utoNqDJyFJ0pUu9qiYYonHyF0EHyJDFCkPb7xPJsBGosS/XsK
         qQhd4/pClvsfxQK5DY5knjMtnWA6Fp+Fg/xhi29aKuY+kGDXhmuskLeX+bX7l+iRwMtC
         gnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702331052; x=1702935852;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N7imiHd03OeHfJqIYuOPkDI+twRgYtwGYnCJrI3xJS8=;
        b=O6evDE4wnuNYwDP6/vZ8YO9Xv8a9Mgkkq6aymD5e7141DTlQX7/mnwZgWI8+kRyMUv
         poU12iljOYkCSE2DZNbGjQ1gMpcD67K3G61E2BP0GhYLhIwf4Kq6RZcVc2qbaI/0HJWZ
         iHTUehw4k4PV4hCqWmy4cRGb6lDQQQ321XF4MjQN5I8pqjDOrUXn/DaIv5Sfrikta5XG
         NxSdVjG0zUT+wT+E4i1/oa2w3DmqPpKu8mh7MXnAcnYn+QAT7f4Hqt1WeCpZTbYWQrd3
         1BupUpbH3g8+ceqEur10oGnL0B1zx7q6AY/6DvXJDLK+gxNAtOnjts6qhsNXfbEEIvCT
         2Hmw==
X-Gm-Message-State: AOJu0Ywn4SuigVJihsaugvoIax9eIg2+mITIt6tbJ6YFRXjr4sUclK1w
	vgr8kXMeqUV31PaVAaPBcMc=
X-Google-Smtp-Source: AGHT+IFbVv36A2VqNl+2IvsIVy/Yz+3YEOynOdb/vNyi2F2LF05fq0tsf0OjqKG98n3VcV01c4DgpA==
X-Received: by 2002:a05:6a20:3942:b0:18f:d416:55fd with SMTP id r2-20020a056a20394200b0018fd41655fdmr6605835pzg.100.1702331052027;
        Mon, 11 Dec 2023 13:44:12 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id v188-20020a632fc5000000b005c66a7d70fdsm6664319pgv.61.2023.12.11.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:44:11 -0800 (PST)
Date: Mon, 11 Dec 2023 13:44:10 -0800
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
Message-ID: <657782aa61b9e_edaa2082b@john.notmuch>
In-Reply-To: <20231207185443.2297160-6-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-6-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 5/8] libbpf: wire up token_fd into feature
 probing logic
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
> Adjust feature probing callbacks to take into account optional token_fd.
> In unprivileged contexts, some feature detectors would fail to detect
> kernel support just because BPF program, BPF map, or BTF object can't be
> loaded due to privileged nature of those operations. So when BPF object
> is loaded with BPF token, this token should be used for feature probing.
> 
> This patch is setting support for this scenario, but we don't yet pass
> non-zero token FD. This will be added in the next patch.
> 
> We also switched BPF cookie detector from using kprobe program to
> tracepoint one, as tracepoint is somewhat less dangerous BPF program
> type and has higher likelihood of being allowed through BPF token in the
> future. This change has no effect on detection behavior.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

