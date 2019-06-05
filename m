Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C60E35C88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfFEMVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 08:21:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfFEMVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:21:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so19253749wrt.6;
        Wed, 05 Jun 2019 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Dg/3HqsWx7s1EU5eDa15GxzKTIcT7wt8v77pC4qg7mI=;
        b=Y2MeqfgWiPCikiSTMSnUJWfwN7LfDeNgLA8XVJatZkojdwXh3D/EP6GSQLh8ziEURG
         ly9/jBeNGXaEJZwvXz8wqSqOMBLSZK8quH6rdIGPSNPyzNVwoJANDkBSbD8n2AMrqf3R
         0M4WhZnqVB9XJG2dynHhYP689C32UrQ3+gJee89HJAC9p0uERtvv2fDucH2UayNKSkiP
         K9Ly1Q67vkDPd8K6TWqngdGD32geaSwKZJG8mdQ/tQUPzSDsjE7PUbFdtUkyDT+1WUjv
         B2LaOcPE6N39rMufBvvkUWJ+2qmKVCXdu1OaDC+Wrk7RZLjcsVWToLGkpm2FQLEL9hB4
         A2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Dg/3HqsWx7s1EU5eDa15GxzKTIcT7wt8v77pC4qg7mI=;
        b=LAwV6YlLxR9w+6vZ3tHRig9ll+WrAezgVE8/14G0XjPEWrgsaedge7UO96mQW9gVLl
         LDlz0kQdESWqpNcAYD35bSeQYa48SyLUZ36hIp3EENfnJW62y0T8VroftP4SV7Ow33kF
         6UcFgEpEGxp92hyG7TPVilhPa8Uitcj94n84Jv2MRRpTySwVShzPRWqAQ9PaWZTbI7AT
         a6XWpcKbPhEfpGEgGA+iCF7PE1n6lCwbH0GzT7B7k1pvpOvT6NQcDgf+7l9n+1jWHl1I
         aRMw6nrZrdp9VIWeLIv433C5ksrHs3cLTq0mBYHzV9Co+SGWcosi8NCUbXTQkzTsI4Mo
         PTDA==
X-Gm-Message-State: APjAAAWWp/+y1+jgkyvi5YQ5FASNz8eZpNRVhbLi3sSo9Ge4yTCheXpA
        Xmg9FF0QmHtJBQtxgtTfNvbunZ85Syw=
X-Google-Smtp-Source: APXvYqx3uZOElXAB0du7JgRrgF64i18zuAuzFkaod+RFJ0hLw9X54jn68OJQMZppa2tR7jOYrYL/Dw==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr22772565wrm.24.1559737310653;
        Wed, 05 Jun 2019 05:21:50 -0700 (PDT)
Received: from [172.16.8.139] (host-78-151-217-120.as13285.net. [78.151.217.120])
        by smtp.gmail.com with ESMTPSA id n4sm18547625wrp.61.2019.06.05.05.21.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:21:50 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 25/25] fsinfo: Add API documentation [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905647369.1662.10806818386998503329.stgit@warthog.procyon.org.uk>
Message-ID: <d88b3276-a81a-d5a6-76d6-1a01376aa31c@gmail.com>
Date:   Wed, 5 Jun 2019 13:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155905647369.1662.10806818386998503329.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/05/2019 16:14, David Howells wrote:
> +Then there are attributes that convey information about the mount topology:
> +
> + *  ``FSINFO_ATTR_MOUNT_INFO``
> +
> +    This struct-type attribute conveys information about a mount topology node
> +    rather than a superblock.  This includes the ID of the superblock mounted
> +    there and the ID of the mount node, its parent, group, master and
> +    propagation source.  It also contains the attribute flags for the mount and
> +    a change notification counter so that it can be quickly determined if that
> +    node changed.
> +
> + *  ``FSINFO_ATTR_MOUNT_DEVNAME``
> +
> +    This string-type attribute returns the "device name" that was supplied when
> +    the mount object was created.
> +
> + *  ``FSINFO_ATTR_MOUNT_CHILDREN``
> +
> +    This is an array-type attribute that conveys a set of structs, each of
> +    which indicates the mount ID of a child and the change counter for that
> +    child.  The kernel also tags an extra element on the end that indicates the
> +    ID and change counter of the queried object.  This allows a conflicting
> +    change to be quickly detected by comparing the before and after counters.
> +
> + *  ``FSINFO_ATTR_MOUNT_SUBMOUNT``
> +
> +    This is a string-type attribute that conveys the pathname of the Nth
> +    mountpoint under the target mount, relative to the mount root or the
> +    chroot, whichever is closer.  These correspond on a 1:1 basis with the
> +    eleemnts in the FSINFO_ATTR_MOUNT_CHROOT list.

FSINFO_ATTR_MOUNT_CHROOT -> FSINFO_ATTR_MOUNT_CHILDREN

