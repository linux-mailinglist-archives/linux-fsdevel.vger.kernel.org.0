Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC859340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 07:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfF1FMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 01:12:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45013 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:12:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so2941622wrl.11;
        Thu, 27 Jun 2019 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SJl+MEcLHxsmC7hL4toqKB0JY3VqT6Z87x0g1KUG1aU=;
        b=Xj0afykFiahF870UUKq5lZkACMiX71h/r/Fjzqg0kwINVwRSXMJIdIxbMFTjvAmKKj
         r9aTY7HivgbiWpxz/UkX9PgvGJ72XaLblhYwGeSp6U1yFk62FguSSfYz0VS9a0/O3k3n
         5ZFZmFdkEvgaz24Ic8fH8oAamBFeBd71A2fqOha9ABaSH1jFBRN6voUSYFZ0yjbgBQ7a
         aIwH0sZXTZ+toSpmqi2C0BL/a98uHowFepcb1aWDJ4GtAmcbFRXJi/ACi2JtShWxiyS+
         j4+65Zfxv50nYfdJ+j6vXWB9anIuclvwSMlxR3cEx0VUf58aJWT8EQ7h61VaCBTqGV/D
         vw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJl+MEcLHxsmC7hL4toqKB0JY3VqT6Z87x0g1KUG1aU=;
        b=lGZUPlzgnOsOnhp3whEf0EDCX2ieGKXHjkH249TQ7Lxt34JUqGrnhkBe8l3eyezyzn
         0GzNvZA5Nrk+VzrU7t5OG5HYvZ0HhuHTKn6jb4da8LpaP+2C+ZbJCXyGMhL91jGk34TE
         quojnPvuol11rGsYyhTecD8XvYxg7kCdGL7QO06K2ukLLSQrFOtZEafuZ2YklGmlVbnh
         YHRzktFwn/nNNj1eSO+oqJysuwwDXDWsMFEBb9VW+sUkYPRkUU5gh0SWkmxbeOdBAoda
         hmZCfXY5fIVpcA7fYmIS8/xt6NMKP/eaP4hDyc16ZJr5CtgUpvCd8sDeS0ob76Yodl7P
         xV7g==
X-Gm-Message-State: APjAAAVQnYMvvA1w4ZwVgoxMU2wqzb8Zc0TjjlDzWjiT2k29xt/UGdqS
        8C7hQKSkgQest0I0ywSL5Wo=
X-Google-Smtp-Source: APXvYqw7iXg661+P0ytoSzuTlnML16T3d6/S3LFZw22cAgZe+5f7D14Z3sXNaeE4rKoyj1MqsaEQrg==
X-Received: by 2002:adf:de90:: with SMTP id w16mr5957398wrl.217.1561698731019;
        Thu, 27 Jun 2019 22:12:11 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id a2sm2218310wmj.9.2019.06.27.22.12.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 22:12:10 -0700 (PDT)
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig validation.
To:     Eric Biggers <ebiggers@kernel.org>,
        Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
 <20190627234149.GA212823@gmail.com>
 <alpine.LRH.2.21.1906271844470.22562@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <20190628030017.GA673@sol.localdomain>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <264565b3-ff3c-29c0-7df0-d8ff061087d3@gmail.com>
Date:   Fri, 28 Jun 2019 07:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628030017.GA673@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/06/2019 05:00, Eric Biggers wrote:
>> Hello Eric,
>>
>> This started with a config (see V4). We didnot want scripts that pass this
>> parameter to suddenly stop working if for some reason the verification is
>> turned off so the optional parameter was just parsed and no validation
>> happened if the CONFIG was turned off. This was changed to a commandline
>> parameter after feedback from the community, so I would prefer to keep it
>> *now* as commandline parameter. Let me know if you are OK with this.
>>
>> Regards,
>> JK
> 
> Sorry, I haven't been following the whole discussion.  (BTW, you sent out
> multiple versions both called "v4", and using a cover letter for a single patch
> makes it unnecessarily difficult to review.)  However, it appears Milan were
> complaining about the DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE option which set the
> policy for signature verification, *not* the DM_VERITY_VERIFY_ROOTHASH_SIG
> option which enabled support for signature verification.  Am I missing
> something?  You can have a module parameter which controls the "signatures
> required" setting, while also allowing people to compile out kernel support for
> the signature verification feature.

Yes, this was exactly my point.

I think I even mention in some reply to use exactly the same config Makefile logic
as for FEC - to allow completely compile it out of the source:

ifeq ($(CONFIG_DM_VERITY_FEC),y)
dm-verity-objs                  += dm-verity-fec.o
endif

> Sure, it means that the signature verification support won't be guaranteed to be
> present when dm-verity is.  But the same is true of the hash algorithm (e.g.
> sha512), and of the forward error correction feature.  Since the signature
> verification is nontrivial and pulls in a lot of other kernel code which might
> not be otherwise needed (via SYSTEM_DATA_VERIFICATION), it seems a natural
> candidate for putting the support behind a Kconfig option.

On the other side, dm-verity is meant for a system verification, so if it depends
on SYSTEM_DATA_VERIFICATION is ... not so surprising :)

But the change above is quite easy and while we already have FEC as config option,
perhaps let's do it the same here.

Milan
