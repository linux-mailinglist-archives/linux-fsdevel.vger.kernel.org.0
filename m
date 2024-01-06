Return-Path: <linux-fsdevel+bounces-7504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E68260F3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E5028290F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C14D272;
	Sat,  6 Jan 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffnGEwUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30AC8C2;
	Sat,  6 Jan 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd20d9d483so5597551fa.1;
        Sat, 06 Jan 2024 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704563686; x=1705168486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJLlPsKBI2QE7O2v23Mya4kKdVct+TJAy3T9+T5haiE=;
        b=ffnGEwUqviig0VYr2kLMzY8Sau2kpXPORu9xuEO1HuBl53YEa0+XJZOrXHCFmJjNuz
         Ij9s3YK9Dk7oxcNIzTq41zyiXRPcTrXuR55WGpxytWGFCLqGkxqEBxdCUJg1XzFx+6lo
         JpiVT03UmZdHfwsuVH74jsM6RBsb12h8M/cE85IThhXhFHU8sdBgQDCxbwIjWP+gGiPO
         zf1ebVo/usxr/7zO2uwBya+NaNj0HzVdssspzsG64KSP1mh4kQwv5FpmWuU3r9U6fHAw
         4Zs1f2I6W5egytMzymwdNamrUSNzbTaMz+bTz7N2OB4H4XHmKdBUGtVOf/CG8JKDujvw
         4Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704563686; x=1705168486;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJLlPsKBI2QE7O2v23Mya4kKdVct+TJAy3T9+T5haiE=;
        b=XpzzHfXDNOgMxXeVPdiBiObw9caBpjjSW45lE5EMuzWJeY+VbHZbARAqN63GX+xAa8
         pbt0Fv6F10SAHVtgQwtj+nYjyuOMdzCVfiuc2hcZLGeDeFpFq3TVO1Znp1ef7KH4v67U
         Zk0nAqHl/TfPVB/eABDjBZZiti2dZsQU8I7mmVvJkGRUQ9WcmXuaM7kmyhvmJXePwYwE
         I6LxshSp0cgp6IxfgjQwT0UpvY/zB1pkMOPa4mfdEGAVSX/+/3q55HkdZFyolQixYOF1
         9BYH7tGvO+q2mJk9RY7iN9SW9rmcXDCRpM4o179ZzEUldoaz7vHBkVwvlEZe2EYyUrxd
         gRXw==
X-Gm-Message-State: AOJu0Yxa/V3flxRL50CjdxSjH9POA+JpURjDgWHXTYLPdbzfsj9j7iwq
	ssqVjJIDofyZLWYxM4nXLT1sDK/EKvpu9nj8JK/66rglMw==
X-Google-Smtp-Source: AGHT+IFGOL4MtEPDbNJwP5gpqeznmoxQaG3cwFR7SCzSRY5n02qRVimrV7W2yulNqbh6lLkBlzqs4lwB7y+4q7NS8Jc=
X-Received: by 2002:a2e:b545:0:b0:2cc:89f4:15a3 with SMTP id
 a5-20020a2eb545000000b002cc89f415a3mr455993ljn.49.1704563685929; Sat, 06 Jan
 2024 09:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sat, 6 Jan 2024 20:54:35 +0300
Message-ID: <CACVxJT9Qn4+cjbEQd=ske+Ch6TG+meY0F8RuhLSVH3+bY7Gg_g@mail.gmail.com>
Subject: rename ext4 corrupting kernels on kernel.org?
To: helpdesk@kernel.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

I remember 2.4.11 was fs corrupting and official tarballs were renamed:
https://mirrors.edge.kernel.org/pub/linux/kernel/v2.4/linux-2.4.11-dontuse.tar.bz2

I'm not ext4 guy but which versions were affected recently?

This comment mentions "6.1.64 and 6.1.65": https://lwn.net/Articles/954321/

