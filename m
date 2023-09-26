Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914807AEEA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjIZOHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjIZOHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:07:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6995FC;
        Tue, 26 Sep 2023 07:07:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c4cbab83aaso4171120a34.1;
        Tue, 26 Sep 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695737259; x=1696342059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+T1kiw5Evo1WrVqxLy5w/b1X7UOVJo+3cJZz1bjJVZI=;
        b=fNkeYkipkcuEUOrNPEarYHLFUmxBmTK/DlOUgvye6CKKkikj514kJZf1E+clSL74Zg
         S7wrA9TdsaHVlUJ4ehk8L+krmdPZ0yeS3uARnFp2JYW586cmN1sIdKntCLR/4SmBHA07
         w5qXXyHUCoi0vAGkzbb/zz5LPtXySJIWnpQwMqvOylPfwjaS9LOUkARiTxqVZbkKhnTI
         tdrZ462VPGC6xGxLAVP9HQ9y9a/a4PTrEuNU7n/NIsJ1C45I3snU7528uSCtaw7ENE74
         O3dfa837wdMCmKGuKCWsld8ThLHCJzHK2Y1sCxRqOm+zYbBsjFmjdWUYHVRVKO69eVAp
         85VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695737259; x=1696342059;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+T1kiw5Evo1WrVqxLy5w/b1X7UOVJo+3cJZz1bjJVZI=;
        b=tLxFDzLOL1uCl3FnmWXK/asU3QVeQ0QmbP/iEcBV4yKMsGHS+KJtCV7f1AQJBTeBjF
         w8MHO1THmr/6UuvHcy4M/Nz4uRxNqfL0GueGGhPnhMo2uFiquznWNzMnFZU0xcxzwh4J
         VnexchO36UCMyUiPQmCqFkbtXvbbV3Yu5SBadrnIzzyhC5sUpPg8gELsf+u/vH4kreay
         k6nNhcE/XKoi+NJLdyoklT2PZNbcLJOvNRUJSPl4cMOW8TYBjPfu0gq+fK/f2l+zSt8K
         KqKvrBY+XsydL1Imxbs1UqLiCJk6+s3jb+zQFusEwj2iEnStJ61JKKL1Di31V6zueBnV
         HdGg==
X-Gm-Message-State: AOJu0YzwvWbeOoDrdL9cIZ5/6mLJfdPxr/Als5KnTlYFvjgo5fE6Yfx4
        R81JGyTHrAyqHKK2YBHlu8WaScplmXLOrFpuRa4/Dlda
X-Google-Smtp-Source: AGHT+IHHt9Kf6fnGHJIEBsMQbVwQyHMuDvQQtMAG/MjoCSV6gXo4Yab1jaPjZ/bhfHP83e/Eu8c0i6uoQaf07uGx2Kg=
X-Received: by 2002:a9d:4b12:0:b0:6bd:c7c3:aac2 with SMTP id
 q18-20020a9d4b12000000b006bdc7c3aac2mr10313264otf.18.1695737259119; Tue, 26
 Sep 2023 07:07:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5d4a:0:b0:4f0:1250:dd51 with HTTP; Tue, 26 Sep 2023
 07:07:38 -0700 (PDT)
In-Reply-To: <20230926-anforderungen-obgleich-47e465f0bd47@brauner>
References: <20230925205545.4135472-1-mjguzik@gmail.com> <20230926-anforderungen-obgleich-47e465f0bd47@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 26 Sep 2023 16:07:38 +0200
Message-ID: <CAGudoHG0-BWTVRG8uZk5Gy8xSwpT8JO5Z=VfY3_dFcCaqhLf5Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/23, Christian Brauner <brauner@kernel.org> wrote:
>> +void fput_badopen(struct file *file)
>> +{
>> +	if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
>> +		fput(file);
>> +		return;
>> +	}
>> +
>> +	if (WARN_ON(atomic_long_read(&file->f_count) != 1)) {
>> +		fput(file);
>> +		return;
>> +	}
>> +
>> +	/* zero out the ref count to appease possible asserts */
>> +	atomic_long_set(&file->f_count, 0);
>
> Afaict this could just be:
>
> if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {
>

This would bring back one of the atomics, but I'm not going to die on this hill.

If you insist on this change I'm going to have tweak some comments and
bench again.

>> +	file_free_badopen(file);
>> +}
>> +EXPORT_SYMBOL(fput_badopen);
>
> Should definitely not be exported and only be available to core vfs
> code. So this should go into fs/internal.h.
>

Ok

-- 
Mateusz Guzik <mjguzik gmail.com>
