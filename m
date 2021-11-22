Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C714592D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 17:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhKVQTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKVQTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:19:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E5C061574;
        Mon, 22 Nov 2021 08:15:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so79332524edd.9;
        Mon, 22 Nov 2021 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eylIbIQdXIjtTBJVN2A51g/oOepdZx04NZk1+393dpY=;
        b=jsRawi3wNpoZnZjkQxu+UGlKyY0UwLIe4dgdxP+eDSRMGGZpK2i8bga+qYsryEdUpg
         luxBBWwg4JCEYRkXyRieXeUf6U/RlnOOymwtAlV3w0tgEAfTjBjPE0mwj9bCt8dsOXZb
         S/aUElUO7JFwhFKXJyJp/EijK6/D9GNPMN6mpEs+Gc/AiSIl31UWnSw7dcpa9FBLSqm/
         W+xcxn3V8DOwWCtWwbI1KRTKHf71q/fm4Qvupo73Zhti63ItJQmZ2NyZIunkPgeHpYF+
         psqqOXh0lnPMxjehxihtDEnKEZIKGBMaWTkqq2GTWwj8XsGJt+my4xvOaP9Y+8Wf4/e5
         X18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eylIbIQdXIjtTBJVN2A51g/oOepdZx04NZk1+393dpY=;
        b=wFrTDKGlfJGcL3ed55obIQyaDi+513L5aUSQ2XVWJ2GDu1kzvo9+PFSxvAEW6D+cUd
         N0Q58EtuV97X15jhqgEGwfeZYmEql3iETi9YZOyN7SjuC+v95f294VlLBXuVmHfMN0Nl
         NzfOjhcW/ENFZJfExmc3KDF8dVgSClIhq2bPkF4brMbfPH9Nvgq/pdDwVuN0Y5igXLXK
         LD2TyUBAouB2UqgNEMi4Yi4b3uBa4yPygRB6bimwaIrEGUumYwsAJdIIJxtXhRfOO4Xo
         lQJViYHcbGoOTA4MkjIBHQxKhy7USMqehEJOzCEPT8HGfqHuDXWjvrNDEZsoo2efJC4c
         xMTA==
X-Gm-Message-State: AOAM531EakJVBOdMQDxAiRhygya4Qat4QZNTO2KbOTqEona67u+NOVNe
        KXIduGW0/TU//eW9hxIbG0rWKlYaN5I=
X-Google-Smtp-Source: ABdhPJxgvfj33EmWX6LrpONQ1Pf51Vwlj/C4OzWS3JjTohZ72Xffejmpxi6U+fCL2Lejo15SeWetNg==
X-Received: by 2002:a17:907:9687:: with SMTP id hd7mr43477046ejc.498.1637597754684;
        Mon, 22 Nov 2021 08:15:54 -0800 (PST)
Received: from [192.168.1.6] ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id c11sm4575954ede.32.2021.11.22.08.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 08:15:54 -0800 (PST)
Message-ID: <588c62d2-7cf3-8424-1fc2-6ed676752982@gmail.com>
Date:   Mon, 22 Nov 2021 18:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
 <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
 <20211118142440.31da20b3@gandalf.local.home>
 <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
 <20211119092758.1012073e@gandalf.local.home>
 <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
 <20211119114736.5d9dcf6c@gandalf.local.home>
 <20211119114910.177c80d6@gandalf.local.home>
 <cc6783315193be5acb0e2e478e2827d1ad76ba2a.camel@HansenPartnership.com>
 <ba0f624c-fc24-a3f4-749a-00e419960de2@gmail.com>
 <4d2b08aa854fcccd51247105edb18fe466a2a3f1.camel@HansenPartnership.com>
 <e94c2ba9-226b-8275-bef7-28e854be3ffa@gmail.com>
 <63f54c213253b80fcf3f8653766d5c6f5761034a.camel@HansenPartnership.com>
From:   Yordan Karadzhov <y.karadz@gmail.com>
In-Reply-To: <63f54c213253b80fcf3f8653766d5c6f5761034a.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 22.11.21 г. 17:47 ч., James Bottomley wrote:
>> Hmm, Isn't that true only if somehow we know that (3) happened before
>> (4).
> This depends.  There are only two parented namespaces: pid and user.
> You said you were only interested in pid for now.  setns on the process
> only affects pid_for_children because you have to fork to enter the pid
> namespace, so in your scenario X has a new ns/pid_for_children but its
> own ns/pid never changed.  It's the ns/pid not the ns/pid_for_children
> which is the parent.  This makes me suspect that the specific thing
> you're trying to do: trace the pid parentage, can actually be done with
> the information we have now.

This is very good point indeed. Thank you very much!
Yordan

> 
> If you do this with the user_ns, then you have a problem because it's
> not fork on entry.  But, as I listed in the examples, there are a load
> of other problems with tracing the user_ns tree.
