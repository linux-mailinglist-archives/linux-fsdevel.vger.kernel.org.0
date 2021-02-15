Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F931B585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 08:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBOHIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 02:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOHIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 02:08:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC776C061574;
        Sun, 14 Feb 2021 23:07:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id df22so6872834edb.1;
        Sun, 14 Feb 2021 23:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hoogOWFRA+fId5N5jNYsYITbZ+7SMKI7kZ1A64Mk5Tc=;
        b=tQbAOOGv052iq/PCl72ZEnKTk1gTC7vkv5W7s+7W1OZOmpE+CehH847ikLlRzVq3Oa
         IjqbhyuzY6E0VCEXGAJVvx1oKBLNPepnFC12t71hVLtBZnHZebtAbGEusAkM8V7yyiUw
         69EfPP1J2/4lW7WHwMG4m2nsY4+nvSJmopCEweRs5OVqyeUiidheKmTLy46//OTaDfn0
         BgnFAHGJZVx8+byeH2IvygdLQT0/+9egVW2BcHIp3ykKu0wbvXsPYRrK/xJkEr7hT7fb
         oAZ0WeyrK4OPiItHk/AxFcM07Oe4gvPEbFla2Zcdb3JHzLMbIlQTrOAO7M0GnzSqAnl4
         5BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hoogOWFRA+fId5N5jNYsYITbZ+7SMKI7kZ1A64Mk5Tc=;
        b=Ap8RMa0vJebIDGHGF1EKjRZ0yOknqbrTFgGdtjLooOaOhsb7eDIcGhsu5Uhp3tMPmq
         iOWRKvBiSW/690L77ve9S+2oyX7YOCFRdfuJuuXr3av0Ua36qb0eNhmhJuDqPIWPwXPI
         0JYwAIkYOV/P+nOdgw19xCkyzZ0FmnB8OpBC+/tH9v3cHt6QQWrThwKL1VxZwQ/Cs+AZ
         7Ruo43HaAK60LVpOjT2UQX8KRdXs3PZ5lnIYtsXAglOm5175Tn2pHoFLhShYd/ywVDkY
         2yLfkspEnYh95HO6xvnYKPShLq/bE4WH1QoraODiooLoG1wCqAbqUxNSEbigCwOAqeV7
         zVuQ==
X-Gm-Message-State: AOAM530/csdLjp4O0fPG3/N3NH4G1XiJsNRHyjC4A0lZdCRS6GvdhyHt
        jzxT+lyvjX7mV9MC+c9fNVfrnhNksMBWHDP0Odo=
X-Google-Smtp-Source: ABdhPJzFA95vhNMci3hbN2OdAB7XhyFKCKkTNyi0z55hoU0C9XEnQ2KTDPdpnN/zMnor3g4/OnJLCH01/ULlJMChR+E=
X-Received: by 2002:a50:ed97:: with SMTP id h23mr3925342edr.353.1613372853258;
 Sun, 14 Feb 2021 23:07:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:2d11:b029:35c:1e41:9366 with HTTP; Sun, 14 Feb 2021
 23:07:32 -0800 (PST)
In-Reply-To: <CAOehnrMK_9uP5j+QCF2qy_08yJEr_u9TEPwJJFogXQCeNFm6Gg@mail.gmail.com>
References: <20210212162416.2756937-1-almaz.alexandrovich@paragon-software.com>
 <20210212212737.d4fwocea3rbxbfle@spock.localdomain> <CAOehnrMK_9uP5j+QCF2qy_08yJEr_u9TEPwJJFogXQCeNFm6Gg@mail.gmail.com>
From:   kasep pisan <babam.yes@gmail.com>
Date:   Mon, 15 Feb 2021 14:07:32 +0700
Message-ID: <CAF=-L+Uk3-fMf_PfCK-u+-vo4zg957xKLB0nqT-qRWn_iDtNGQ@mail.gmail.com>
Subject: Re: [PATCH v21 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     Hanabishi Recca <irecca.kun@gmail.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The bug can be reproduced easily with following step:
find mountpoint -exec ls -d {} + 1>/dev/null


2021-02-14 2:00 GMT+07.00, Hanabishi Recca <irecca.kun@gmail.com>:
> On Sat, Feb 13, 2021 at 2:27 AM Oleksandr Natalenko
> <oleksandr@natalenko.name> wrote:
>
>> Hanabishi, babam (both in Cc), here [2] you've reported some issues with
>> accessing some files and with hidden attributes. You may reply to this
>> email of mine with detailed description of your issues, and maybe
>> developers will answer you.
>
> There is strange files access issue since v18 update. Some random
> files on partition became inaccessible, can't be read or even deleted.
> For example:
>
> # ls -la
> ls: cannot access 'NlsStrings.js': No such file or directory
> total 176
> drwxrwxrwx 1 root root  4096 Oct 20 10:41 .
> drwxrwxrwx 1 root root 12288 Oct 20 10:42 ..
> -rwxrwxrwx 1 root root  8230 Oct 19 17:02 Layer.js < this file is ok
> -????????? ? ?    ?        ?            ? NlsStrings.js < this file is
> inaccessible
> ...
>
> To reproduce the issue try to mount a NTFS partition with deep
> structure and large files amout. Then run on it some recursive file
> command, e.g. 'du -sh', it will list all access errors.
> Can't say what exactly causes it. Filesystem itself is not damaged,
> when mounting it via ntfs-3g, ntfs3 <18 or in Windows it works
> normally. The files is not damaged and chkdsk report no errors.
>


-- 
Sorry, my English is bad.
