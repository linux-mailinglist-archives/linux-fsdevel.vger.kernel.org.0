Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2CF3346D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfFCQBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 12:01:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44935 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfFCQBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:01:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so14010632lfm.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2019 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwAb+fjZakb4SE3XBU2vDo+/FsY9YcZ27a86p6XEaAs=;
        b=RAknaK6HJEQ5zkQCebN0zIeweiFarG87mqZWgTXpU/mJYEt/DEie3H3GUrpMAkizhf
         DAjrek0lkfPev895ypNRKOioKwTHoHppJhQCGVAq+NcSFX9QQKad4aQE4NgXUszbotod
         HpqE5XLtyZaVR5/qdNcdgb7ceGwsUQvR666euqtSsqc3OmniQ2styCZ5A6fa8wFzmYab
         XQWs/R8Zv9uWMeeBYycMepmlBwpgKHulJsqz5096zetgsMifJSoInjVF+zauJ7Lcd+ZK
         poQFphqqutbXYOSTji0TJpFkZiZboByLaWGvrwJDqBIG4csRSA2uepIebTq5Rhzk3wDG
         LSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwAb+fjZakb4SE3XBU2vDo+/FsY9YcZ27a86p6XEaAs=;
        b=lnr5KeWrPqIZRqA1jdGjYv0ZkltQc0dfuVPozVqxWlH41wqbmNQpePMDWM6U/LMRgx
         r0sWlY3v3La6XkchJg1pSbr0tXPwPAoZfNv4OHz2BS1KHTgyRr9var24v4C8qQzXLRoj
         QWG99IeeqPz65kuYogWo6qyGLZT8a7oYwVnRBJUitFBoQugPSD/Ispp94SpYqV/BxVUE
         5DmQKEOU/nj/l1WX+XH1eOqZSzy/8V+BRT+1U336DEshrnbMUDeiCFr8gKsQg6kKxrad
         ElzNdc6svMKRZCR8x8aXv88nnoydd6JLd6ZVdO6d4OxAH8nVMYx5JhN7935X1shA9/5o
         EPhA==
X-Gm-Message-State: APjAAAV1vrzY4Z1SgXKZk2agY2Gr5p0fPAXLPCwtt01AInud05qJbNuq
        7lJw0qhuuCSmnHlBiEaWO7qhW1aZISI/UWxThD/f
X-Google-Smtp-Source: APXvYqzF84jTm/2bsJE8Z7872PStSoK3LKry51awtLL9AllXtZ9eS6eWxt9+Bys/+Qo1UsfILlV7LgRg51RsyxVhV98=
X-Received: by 2002:ac2:446b:: with SMTP id y11mr9514878lfl.158.1559577695379;
 Mon, 03 Jun 2019 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <fadb320e38a899441fcc693bbbc822a3b57f1a46.1559239558.git.rgb@redhat.com>
In-Reply-To: <fadb320e38a899441fcc693bbbc822a3b57f1a46.1559239558.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Jun 2019 12:01:24 -0400
Message-ID: <CAHC9VhQZuOXiK4yj4xeRwGF_qepeg7qDL02GDdYhwTNRLRdmPA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6] fixup! audit: add containerid filtering
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 1:54 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Remove the BUG() call since we will never have an invalid op value as
> audit_data_to_entry()/audit_to_op() ensure that the op value is a a
> known good value.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditfilter.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for sending this out.  However, in light of the discussion in
the patchset's cover letter it looks like we need to better support
nested container orchestrators which is likely going to require some
non-trivial changes to the kernel/userspace API.  Because of this I'm
going to hold off pulling these patches into a "working" branch,
hopefully the next revision of these patches will solve the nested
orchestrator issue enough that we can continue to move forward with
testing.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 407b5bb3b4c6..385a114a1254 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1244,7 +1244,6 @@ int audit_comparator64(u64 left, u32 op, u64 right)
>         case Audit_bittest:
>                 return ((left & right) == right);
>         default:
> -               BUG();
>                 return 0;
>         }
>  }
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
