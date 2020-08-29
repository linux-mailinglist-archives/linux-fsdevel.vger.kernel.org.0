Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991E02567A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgH2Mxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2Mxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:53:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D8C061236;
        Sat, 29 Aug 2020 05:53:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so1645904wrk.5;
        Sat, 29 Aug 2020 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6yGdyFT3n0KnKlJYrQFKElmgg31XlIgfsR8x4R8Vpz0=;
        b=NbUlFu4uRhCVVnOoUCgEpoK00f26ZNajuTH+VdZl8GE/72fnEUNbfZ+VwRJTOfjk+y
         OfdP9k5dYaZZ4UKXX4KihvzB2tZtFdWre6AGj+2hQbWhd2F3lUyPDzI7zhQvzcG5mFbr
         aKevqYW4fK9ShakWvbnRFWYQ0TAKYBa5YYexiB2gp6acwomFptX+GKr4tBRB10RLfAxS
         l0FKXbXZTr9EVqLGLMGGh0TVFMLOEQz8kKT4K++ePJKTcpl2Y72BK8Kj+AVJaxnVBnQk
         duUtyZGDhRIftQT41tmXYF0iYq+5UVgn4cWT8jl/RXQEsoxN+gt/Y3xovXHJMKpcct/S
         QqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6yGdyFT3n0KnKlJYrQFKElmgg31XlIgfsR8x4R8Vpz0=;
        b=Kvwn3ia9B6nC/Lajv/ZiBBo4aeexGIrcTVGqms7PLbLJvVmWm717H85jnBWgTBrLpX
         yfGyVvSQye7PvSVIYjXCcLZgGBu6trNXbPCb2zyJEKplKM9jFVIxUqFTHoyvIAEyna1Y
         +BDdS3vEFC9cX59XNXerqELK596AR732NCgnuCQkG080ZrAalR9xvcbrKzXWhB9HLDWX
         9w/rxLwTOGLz8KrSfuTmfFYtAJxNYgBUQgor2JRyNYzOOOO0t5LBibnPyvcYOz+At21F
         eTO8WEhr25513cTL7HUZKQChWMkuycLpyLpOVImceS/iC+PEX7SRXfIpV8Vgtxx+t1/M
         i/iA==
X-Gm-Message-State: AOAM530RFknYo9hrHLiBBY0IErN5fIqIjX24y9KCQQ2G+kcZBaLLKgFO
        9rY3yheCafRhrDKfGJeQW48=
X-Google-Smtp-Source: ABdhPJxPhih1jhFdoyfrpKH2NsVBqJDFhiwRnMq08LZY4j1iEGa6eowLDsiBzGWEAveVWMhRMUmgyA==
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr3708597wrt.132.1598705615775;
        Sat, 29 Aug 2020 05:53:35 -0700 (PDT)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id s12sm3185424wmj.26.2020.08.29.05.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 05:53:35 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <e2decd9632cd4d218fb83e96c0c37174@paragon-software.com>
From:   Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
 /dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
Message-ID: <3c1e5918-347a-d1e6-44ce-338c7d0dc7e4@harmstone.com>
Date:   Sat, 29 Aug 2020 13:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e2decd9632cd4d218fb83e96c0c37174@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/8/20 5:52 pm, Konstantin Komarov wrote:
> Hi Mark! Thanks for the feedback. It's reasonable concern, but the open
> question is how to access those NTFS attributes which extend the DOS
> attributes. user.DOSATTRIB may be good for FAT32 as DOS attributes are stored in 8bit.
> However, this does not apply to NTFS (32bit attributes).

I'm not sure why this would be an issue - the obvious way of reading
user.DOSATTRIB is to use sscanf into an int, and then check for the bits you're
interested in. The NT FILE_ATTRIBUTE_* values replicate and extend the FAT
constants used by DOS, so it shouldn't cause any confusion only exposing the
full 32-bit value.

