Return-Path: <linux-fsdevel+bounces-1888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583937DFC02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 22:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C041F228B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660322307;
	Thu,  2 Nov 2023 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xgRMslaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36F222301
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 21:32:46 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC453195
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:32:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d10972e63eso212166166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698960761; x=1699565561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq5NPo4MczJen086IQAvce9UPFocIswVxg9xIedCGQw=;
        b=xgRMslaT1VfBaZkQ3faINVjc8DK09pbRq+078Ra9cm8HShgS9Yn5RydVFqI+QM9znk
         RlVzg7etf8M5Hjbpd69AbTwZtg0TpPg0J/QRDzjN5iNCkDEO6YY1a8VVLkDG8y32St16
         4PyTJKsiogtPLZvPTCF5GBhco3Pw2NaKkTAMAV8De2SPe5f5UrZvLotWvdj1Blpb8A0N
         XL78pkZGq52OrQ0Xb36Ui+wPT/umzNj5EkqT/iJJ6ng19etQRvVYn+L4zu8qqxFciOkM
         ipw1zJ0xqZyHQnbzNhU2Uvv2/Novby1zLlO0I1vW0gsu4eJzx2e7U6wCfz73AXCppLV2
         WH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698960761; x=1699565561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq5NPo4MczJen086IQAvce9UPFocIswVxg9xIedCGQw=;
        b=bLYsR2y0oW2JPklRdIgBQjNGBJYc/6fUMjdkhfKnVf3i4r01pNK7il7TvIHQ+TIEnz
         wnKpJIyx8MFgqYwBA28ZVBdS+NV9fU4UjvJAKShg0x8Eat0W0IEbETO0fSZX5V+piTpe
         IdBERJi9bLuLCFJ3j3MN9MwBF3KAczHcp83fiWZvUCDaNqirFeTEI0HLUX2LCSpN50wt
         fB+yCp8Vt+40Bd7Tk1E/oRasqEqdxxHADW/7ABugwct05Hfm7qs1YJ6NgPfpuQt5Qw7Z
         2r3SrhawHsDvYIlgPhYQfa0i0jYwmteX1UA1T9ZbYgg9SRah7ZbyN5l9CLLq1JWlblME
         gKpA==
X-Gm-Message-State: AOJu0YzDsNHu27nHxxjKm5ASfPRdkNSyM+PV/neiO28p+owGPUYXxtUs
	H7ftRMvdY/tGUrJCpBlbE8lcDuf/YMRrqMyS/YOxvg==
X-Google-Smtp-Source: AGHT+IGyZP9u6aAbNP6NikHtNCgyA7xGVqp3DPsClZgLA9ftj3/+w+BBKe6H9xBGihWxGn5Wl/jeqaf7Czg+Qc1ZkLA=
X-Received: by 2002:a17:907:954f:b0:9c4:4b20:44a1 with SMTP id
 ex15-20020a170907954f00b009c44b2044a1mr3798351ejc.65.1698960760931; Thu, 02
 Nov 2023 14:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com> <20231028003819.652322-4-surenb@google.com>
 <ZUAOsn9Fj/qCo+xg@x1n>
In-Reply-To: <ZUAOsn9Fj/qCo+xg@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 2 Nov 2023 14:32:02 -0700
Message-ID: <CAJHvVcibtwWom6w=jdYa+712ZEVM3Kcy9RQwgfgHi8b=1nF9jg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end
 of the test
To: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com, 
	lokeshgidra@google.com, david@redhat.com, hughd@google.com, mhocko@suse.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 1:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 27, 2023 at 05:38:13PM -0700, Suren Baghdasaryan wrote:
> > uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unma=
p
> > areas used in the previous test run. This approach is problematic becau=
se
> > while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
> > which might differ from one test run to another.
> > Fix this by calling uffd_test_ctx_clear() after each test is done.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Looks correct to me as well. Thanks for fixing this, Suren!

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

>
> --
> Peter Xu
>

