Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1824C10E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgHTOxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHTOxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:53:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7DEC061385;
        Thu, 20 Aug 2020 07:53:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so1351992qtq.12;
        Thu, 20 Aug 2020 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=44ZB8PFzHhKqcbXWMD6Va0wRYGDqUcyhMhzfY4YQ1AY=;
        b=KWph9cqGCxFMinjy4wJXvbbJBDiEnoZyyxvKeiK4HV4fEBOF3zCuJHBv+9XaLP2ed/
         Ab23LFvkXrlYCq497rPxTnnybNdo2XCPlWAQqfaMR7J1VVMfiwtPdNi3YEZlC0WSlHq8
         qPzcf8pLEyi1X1e7zAIrbwKdGm3QadvPDaaFWvV8VtRj8tM/Vv9xhG2pOTyAV9Hs1Fl9
         4h80M3F1YxRSjJyn5Jrm1uCM3pAbQ9XHnIwxzRRbt/m8rfmdlM91I4YgQ9FV54Q6Fafm
         l8hRf4CqS9A/pFb+LvpyrEKk3oYS3NISA1xeWMRbRk9SP26SrzEE1PFCUhftiFJ+b/AT
         VGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=44ZB8PFzHhKqcbXWMD6Va0wRYGDqUcyhMhzfY4YQ1AY=;
        b=j8CHv3TPgCJr6niEAF2a5EC21f7GBOHcTtzq6m3wR8rXf3s3g7zX9cngtwdWhgvuw1
         wITt4d2Lpyud5PgYDEcq/coBLN5tjVEOUOKv3fmGKMGYFiZRdDeSRJ3E/yqw0QOtd7LB
         4naBSFr74DwGBj5KUIOejR9Wb8K4q6TPTgOejNRYpCA4JtyukzXu/uzoXEhbo15HHxYW
         2rbPAXCg4amhjDLyJnLq1JITi6rTjjruIgcXb41ErsxWD7lyjMvt6MXFj+pnSccFQOIq
         PPtozPGVcPxQC5iStaz/+SAcLIRBjxrOfLdRd2FJIseJsL2cVQ3CvA/D8wsg1OEGwEcc
         YgKQ==
X-Gm-Message-State: AOAM530H84BkV8OzHg4w6WNhpih3L3vwvqL6gUyTa5e96AipN4GGNkNw
        oIzYs9jBvntb/tiDhfDq+Xs=
X-Google-Smtp-Source: ABdhPJyy/yIvXnANQQ+1G0A54u1x0aSVrMsahx6g+cJgV8V9ryLTRR5Cow7sjtpDD+ppAPgB0j/lMQ==
X-Received: by 2002:ac8:66d3:: with SMTP id m19mr3079342qtp.276.1597935214944;
        Thu, 20 Aug 2020 07:53:34 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id v45sm3249961qtc.42.2020.08.20.07.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 07:53:34 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] selinux: Create function for selinuxfs directory
 cleanup
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
 <20200819195935.1720168-2-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <cc792e5a-b74f-3d0c-c52c-9fdaa6efc0ca@gmail.com>
Date:   Thu, 20 Aug 2020 10:53:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819195935.1720168-2-dburgener@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/20 3:59 PM, Daniel Burgener wrote:

> Separating the cleanup from the creation will simplify two things in
> future patches in this series.  First, the creation can be made generic,
> to create directories not tied to the selinux_fs_info structure.  Second,
> we will ultimately want to reorder creation and deletion so that the
> deletions aren't performed until the new directory structures have already
> been moved into place.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

