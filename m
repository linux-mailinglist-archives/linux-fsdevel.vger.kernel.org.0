Return-Path: <linux-fsdevel+bounces-4412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090337FF2C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B712B2826DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7A51006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xy+iDHxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CF196
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:24 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35cb8fe4666so145385ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701354203; x=1701959003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kfE6bXsFNbNbn/JQBZL8mpRLo7M173Nx0eMo++x0o8=;
        b=Xy+iDHxKMQHb9j6gaGrn8NfF79CxfMOks+ty6CjbiP/LE0esGV4xOiEX1SG2REthVL
         0C38cjNkjMeU8AM7o1jhD6q+4NFGJbpsSg07e8MQEPFsS8cZhLRhQdRtHTzVnOX9vKhm
         8ozMdLDOLRbSbTyGk+yF9REsXQpxUp8ub7qMcI9N4wuZYyjmJoK7k12qXdr4MVmwDmpI
         2zVOp1VQ1Ufrr4ZnOk4nWiHS757gT2fMBpFly1DLyJQTxmwEj3htcVptfD+rbmiMKTIO
         FI2Pq1E3+3W5EYrAhKsHUXLgdWr/3F9CTNlepTO1k742lgAHrfRKi8OG01rADHJ1sYsM
         VP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354203; x=1701959003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kfE6bXsFNbNbn/JQBZL8mpRLo7M173Nx0eMo++x0o8=;
        b=OltogioGtesDaTas4AGfNSTrWGATHZ+9dV5EJvx3yNLfUlPSL/SmrD8kXMlxO7B2wD
         2/aYJATwwgO6ql5mA7YVaZOE/orpTF1TO+aX14LjNfN6uaZcOF/aeseJezMdY2XCuam8
         /+pI1CQ/woML6aIJYjrqfOUmMvYsOgg/gvkXK2fy0RvfAN9bMJdIrfpewRO+T+5nkWUj
         6vIwdbxRc1OQTrE4mKppSzd7+uFhoEVMhTgjCM1qntBZ7MrZYHdKaQ2X8wOAdZ7bD7ft
         EfKUaDgJeFBHEO7OOCsXfF8bywXhrPUTsSHlS//DaPN9H16ZQg9qj+vixvgvaj0QA5I+
         8JoA==
X-Gm-Message-State: AOJu0YymA6m9eASkBrLnuzF+1cQ1F7mEpZI1Zli1i+JrPALwg4CEqyPr
	+4I8nxjZlcQtuwowyHdr8I7ZNA==
X-Google-Smtp-Source: AGHT+IEPvKacwRpr0tpgod4bnL+Wi895NT2s2kpTl3G1fZBK41tGis05/OxnHgs6shra0alAZicSYg==
X-Received: by 2002:a5e:cb02:0:b0:7b0:acce:5535 with SMTP id p2-20020a5ecb02000000b007b0acce5535mr23303217iom.1.1701354203562;
        Thu, 30 Nov 2023 06:23:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a02cc1a000000b00463fb834b8csm308647jap.151.2023.11.30.06.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:23:23 -0800 (PST)
Message-ID: <a31d86f8-23d2-426e-8266-63c046af89dc@kernel.dk>
Date: Thu, 30 Nov 2023 07:23:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/5] file: stop exposing receive_fd_user()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Carlos Llamas <cmllamas@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-4-e73ca6f4ea83@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130-vfs-files-fixes-v1-4-e73ca6f4ea83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 5:49 AM, Christian Brauner wrote:
> Not every subsystem needs to have their own specialized helper.
> Just us the __receive_fd() helper.

s/us/use

-- 
Jens Axboe


