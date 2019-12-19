Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551DD126791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLSRCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 12:02:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSRCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:02:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so3432298pga.6;
        Thu, 19 Dec 2019 09:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QmZHBv3VTqpxW/+akPp/0Up5TSxjNx51R37o6VFJo/8=;
        b=Rxe+ElQQdLHhw9LCWF1MT+SEbUVbP6UBVHaNYlY8Y655lU5jeO2JXQ4vuSKHpar2Bx
         evQIWX3uKVu1nLpE4Jpk4DbtISWARtGqBhJBxoQdPqsuP2KxYFNEhRiR0qcKOs4mXRjM
         YESOA+egwGyNcxg9KwICjh6RlwcuqTtPs32YF4w529lg8+J1FsqORTNH0Crom2oKc2nO
         2yWTE8Q54pbpzcrogjN7XTiM7UecKzIWaZttpMXY2M0c32z6CYiYTol+CkQNjEIx9wc1
         +aEOGC8noMRzk9kkCrgW6dSsIJ4GCYMGwVvQc01ronCGari5RXeHqUw7o9VTlRs1PWtA
         sv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QmZHBv3VTqpxW/+akPp/0Up5TSxjNx51R37o6VFJo/8=;
        b=BxVoafVSWrxDH7drp6eYwN8zaMRgibT/17YhuvDMQhOJgyafTYQdGHHnGEZzpV12av
         asbU+orKXLIQGD4tZARBSZyG9QZ5tzURRdIcUtMblbHSwKnpqT2m/w2/MtnurVQUMEZx
         6ocVkSXC/S6rYll152lI54grt6cHSD13HkS/Vz8e+nabxz3CidYksBjFWe9cO4iJfId4
         OyYAkS/19wtSJTX4VvvxTZ4iHAK3l+sVo5CmDZ/IDfoxOY4vd0/EHXOdKiquxg529R1h
         5Qs+RmzE+72+PNGD5U7J+zWdYHtiMglq+u3Sq3uJyOHmsSfbbmkxguMp8zpa0BXOhFO6
         BuYg==
X-Gm-Message-State: APjAAAVQUajvqh0xmQSrku59UJnwpBh2jAufO6Gr8XgV8JNrVUX5J1Nc
        WHwbfm+R0OglDEQTPAdNORqtFeXy5VM=
X-Google-Smtp-Source: APXvYqyebZwOJg1dT7jXsy0er9lcMqa/aeNpp2VMPO3d+LC5lWQ7Ugfd7hJLcic/CSI7Ym+uGIn6Vg==
X-Received: by 2002:a63:e042:: with SMTP id n2mr10338201pgj.308.1576774923465;
        Thu, 19 Dec 2019 09:02:03 -0800 (PST)
Received: from ?IPv6:2804:14d:72b1:8920:a2ce:f815:f14d:bfac? ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id v4sm9038094pgo.63.2019.12.19.09.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:02:03 -0800 (PST)
Subject: Re: [PATCH v2] Documentation: filesystems: convert fuse to RST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     miklos@szeredi.hu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
References: <20191120192655.33709-1-dwlsalmeida@gmail.com>
 <20191219095356.4a3ad965@lwn.net>
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Message-ID: <2eba770a-f566-d704-35b3-7c00995bbc76@gmail.com>
Date:   Thu, 19 Dec 2019 14:01:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219095356.4a3ad965@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jonathan! I hope you're doing fine.


> So I have to confess that I've lost track of where we stand with this.
> Holidays and moving house will do that...apologies.  In any case, I have a
> couple of additional comments.


Actually Miklos replied. While he did not comment on the amount of 
markup used, he had this to add:

> Hmm, most of this document is*not*  an admin-guide at all.  The only
> sections that really belong in that category are "What is FUSE?" and
> "Control filesystem" and maybe some of the definitions as well.   The
> mount options for fuse filesystem are not generally usable for
> actually performing a mount, most of those are actually internal
> details of the filesystem implementation.
>
> So I suggest leaving this file under Documentation/filesystems/ for
> now and later work towards splitting out the admin-guide parts into a
> separate document.

Please let me know what you think? I can do another pass to clean this 
up and remove more markup, no problem!


-Daniel.

