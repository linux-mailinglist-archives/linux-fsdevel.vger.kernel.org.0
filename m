Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9E3E8630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhHJWro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 18:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhHJWrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:47:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03151C061765;
        Tue, 10 Aug 2021 15:47:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso6571272pjb.2;
        Tue, 10 Aug 2021 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yIH0KUnZv7CbUNuLVwKk6Yjj2btfYGCd33gAi0qy9lk=;
        b=ocbTw3+op+JN/IWY/wUmffxiA+QAfcrR9mImsaFZDuNkDLCwp+PxLcwflgxgjz3wst
         ckQs+f9MjZuAzdFfR2VLgZ9+lgaITXcI66cBDksKJWBpJXQMUX4n9TPIaa/cdcPAKnOg
         URRXWcuppxAnjw88ww3w7VnoRRrNWKDlrVb+9lRBe5NlySmaZq7x5SeYQgkDNHTEv/kH
         XbISyjnk2ZcWk0jRK++PeGVZbGWzK/+B4gKpkfrcCi1Bjbatfeyqr73THSUUXjg+wr32
         kCkFWKX8VbpzhZ7iLVQgxviwRSXY7AVu2bUTc4L4sLNmGnRZIUzOlk3GsxLayj2svRPP
         msXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIH0KUnZv7CbUNuLVwKk6Yjj2btfYGCd33gAi0qy9lk=;
        b=Yj1d/vjexaciN+AMlT27hv/0SeMCVBTkh6CSjwn55p4P6xXO5pZwmlTtoSpYzviBmv
         p3fMMDInBTI/0GqWpXu+sZ7do5+9SxZ0AxpEUBI4hk3PbonqLcGD6Au5/rJ+YuC1nx6U
         RQ8X6WhstXs3hoNI6vdDbfq4+ujazpOgHHF6i5jurusJNk+wzeFji2Zv54TXkEo7AwRv
         hZSwpYE6c3HrxdjPrWPoQYk4z048kSpunBixbg6+sgE9LTD3j7gPiyrvxjGOTyksSAgg
         Hj7UAubCtLgR0vHoToAIbdlLhCZe/O3PTrYakFeXYwP7kP651RmaE13ZlL4zVwO1W0xn
         gM7Q==
X-Gm-Message-State: AOAM531BdonvfkDfKIqzMJdtDzE1+StfOtl8DVJK1KYqNu88/7AogGjG
        v6Tyst2b5D1AhvJ7RQ45Vqg=
X-Google-Smtp-Source: ABdhPJwUU92PjtwHfiGs9aAvP9MCKxajQoXjy2XBtLRBugTZJRlm3qbIOI131sqrg4GwWhjhqmA6vw==
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id u7-20020aa783870000b0290395a683a0e6mr31367561pfm.12.1628635640525;
        Tue, 10 Aug 2021 15:47:20 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id a20sm4208799pjh.46.2021.08.10.15.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 15:47:19 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <d5a8061a-3d8a-6353-5158-8feee0156c6b@gmail.com>
Date:   Wed, 11 Aug 2021 00:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

Some further questions...

In ERRORS there is:

       EINVAL The underlying filesystem is mounted in a user namespace.

I don't understand this. What does it mean?

Also, there is this:

       ENOMEM When  changing  mount  propagation to MS_SHARED, a new peer
              group ID needs to be allocated for  all  mounts  without  a
              peer  group  ID  set.  Allocation of this peer group ID has
              failed.

       ENOSPC When changing mount propagation to MS_SHARED,  a  new  peer
              group  ID  needs  to  be allocated for all mounts without a
              peer group ID set.  Allocation of this peer  group  ID  can
              fail.  Note that technically further error codes are possi‐
              ble that are specific to the ID  allocation  implementation
              used.

What is the difference between these two error cases? (That is, in what 
circumstances will one get ENOMEM vs ENOSPC and vice versa?)

And then:

       EPERM  One  of  the mounts had at least one of MOUNT_ATTR_NOATIME,
              MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
              MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
              locked.  Mount attributes become locked on a mount if:

              •  A new mount or mount tree is created causing mount prop‐
                 agation  across  user  namespaces.  The kernel will lock

Propagation is done across mont points, not user namespaces.
should "across user namespaces" be "to a mount namespace owned 
by a different user namespace"? Or something else?

                 the aforementioned  flags  to  protect  these  sensitive
                 properties from being altered.

              •  A  new  mount  and user namespace pair is created.  This
                 happens for  example  when  specifying  CLONE_NEWUSER  |
                 CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).  The
                 aforementioned flags become locked to protect user name‐
                 spaces from altering sensitive mount properties.

Again, this seems imprecise. Should it say something like:
"... to prevent changes to sensitive mount properties in the new 
mount namespace" ? Or perhaps you have a better wording.

Thanks,

Michael
