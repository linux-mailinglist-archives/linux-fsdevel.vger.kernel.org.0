Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2E37971E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhEJSk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 14:40:57 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E88C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 11:39:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so3690559oot.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g8l7+5rEF8AvFOsurgLEUvcHC9f4CI125Iv6yYhvIY8=;
        b=DW8jtesdLRWPifFX8gq26TGODCUKmxz0lpotY+DwtHiITPnYepC90UWMHlEOAmw8q/
         b6nnh28WgHVtoD4lB9LJfPCZNOXB4ygvAN+8v2ms/7Hw6F+ZTlWFYcLPEolT+/9Y9U9Y
         WAtC0Lskzc8vGAmeSP5CmP6YRqH/3LwrZfsflC2He0T5Bf0eqkhZ++cGYlLgOA+ADr+a
         F/OjuM8Uae9a6bwzzEHuTSxYdIpapPL7KzvVaUFVh7AbqIl57vQPAXmBeDohgFVemZLQ
         Rfh7KEVAbsrkT+VaqbunYCB2KwzAvlKbw7N6h+lAWhUJjHxXYEgx/jRSZ4u+hp3lMQwe
         uuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g8l7+5rEF8AvFOsurgLEUvcHC9f4CI125Iv6yYhvIY8=;
        b=PISlBeu+diTKafZxWEXcJZ17L7V3tVnhoiVMRq0sbjiNQyuhka6oP6hXCjuBHxNTR7
         jO9H0n05iBMRZnf+yCWfYSL+5QSqlUz5FlV4wH1hCfSx8KaHQDjB3uXZkyikUEg+GYs3
         HqoIOcsbDaD/YNnpVvg4+Z/Igp18dvzF8oEVUXvdg+rOew+CUyotSYo5V/cfoo7dksKi
         hUjTTqBVwMnFxGCwbDfdBHqwoJD8Z3vvg0wAu7L4+nyoBlD+pKGTruYULfT0W1Petc7W
         oSbOXuiezv3hTTeQm/gQ/VmIhcEY/X60fN+B9AMiVXsOtNrZCeTXmioE3b7zcCsUA8yQ
         6gdg==
X-Gm-Message-State: AOAM530H2SLS4Tiusk+eCuPz8gaQEFbGveYWNESPcxaSwkcodHys2Rdg
        R0+a10D/n1FJCypU2DBMDVwZ0cgwXQ0XmgYbkBg=
X-Google-Smtp-Source: ABdhPJxs2B4IjeQTCAP3r8+wnwV0X37Lj0USQ0D9AF4toRw/vN0E2ltQagQFGSGqev2vIT3RQ2AA29zqbYTqnwfp7BY=
X-Received: by 2002:a4a:be86:: with SMTP id o6mr2502139oop.67.1620671990945;
 Mon, 10 May 2021 11:39:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:4118:0:0:0:0 with HTTP; Mon, 10 May 2021 11:39:50
 -0700 (PDT)
In-Reply-To: <YJlpvAXwpFtVlcy9@localhost.localdomain>
References: <20191225172546.GB13378@avx2> <20210510134238.4905-1-youling257@gmail.com>
 <YJlpvAXwpFtVlcy9@localhost.localdomain>
From:   youling 257 <youling257@gmail.com>
Date:   Tue, 11 May 2021 02:39:50 +0800
Message-ID: <CAOzgRdZfKU7qeO3Tmbk0=kDDeydOw37aDB9ibAh3R6i3eK2_Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc: convert everything to "struct proc_ops"
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I delete "	.fops = &qtudev_fops," , xt_qtaguid can work.
but dmesg, qtaguid: qtaguid_untag(): User space forgot to open
/dev/xt_qtaguid? pid=3860 tgid=3235 sk_pid=3235, uid=10159
i don't know it can delete or not.

2021-05-11 1:13 GMT+08:00, Alexey Dobriyan <adobriyan@gmail.com>:
> On Mon, May 10, 2021 at 09:42:38PM +0800, youling257 wrote:
>> Hi, my xt_qtaguid module need convert to "struct proc_ops",
>> https://github.com/youling257/android-4.9/commit/a6e3cddcceb96eb3edeb0da0951399b75d4f8731
>> https://github.com/youling257/android-4.9/commit/9eb92f5bcdcbc5b54d7dfe4b3050c8b9b8a17999
>>
>> static const struct proc_ops qtudev_proc_ops = {
>> 	.proc_open = qtudev_open,
>> 	.proc_release = qtudev_release,
>> };
>>
>> static struct miscdevice qtu_device = {
>> 	.minor = MISC_DYNAMIC_MINOR,
>> 	.name = QTU_DEV_NAME,
>> 	.fops = &qtudev_proc_ops,
>> 	/* How sad it doesn't allow for defaults: .mode = S_IRUGO | S_IWUSR */
>> };
>>
>> I have problem about ".fops = &qtudev_fops,", convert to ".fops =
>> &qtudev_proc_ops," is right?
>
> No! Those remain file_operations driving your device.
> How is it supposed to work otherwise?
>
