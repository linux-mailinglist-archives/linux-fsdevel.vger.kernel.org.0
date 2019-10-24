Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD96DE2760
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbfJXAed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 20:34:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41025 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfJXAed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 20:34:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id a21so166753edj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V0el+KO6mbeUOnS5AFS4rTzPV5WtSr/T7Kw/ovvO38s=;
        b=zenH0hN0aK+dRKLphbYnaoT4aup6bwwfvZZDgQf/KbqDHrCtTVTFt0b/0yugx3nznz
         pgF0oxmOO9VwXGZh4lth+bSVlC2yJj8nCe/N3vKBBmoCp1J7bJVpdfH/YYPuJSp6CEgl
         IgL5RaPVSvpIZXLfsbCQejaUCjYtS76nsWkTXjlGCkDNAbsK1NRUfluVAVgB+tVRVESD
         93fCtYhAFISVBnVtcn/sxmF5Fiz/xIMBsW5vwcTSIaweduKrXHsVIRHJYNECCOpC6ztn
         3tTk0gZuBK1/D9FWKN23ui8d/29xIa38IjyNDBzf+Z6pNVphpK5hEwchlvD3haTuBKm/
         uMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V0el+KO6mbeUOnS5AFS4rTzPV5WtSr/T7Kw/ovvO38s=;
        b=s3AVyp5xdq39dal+2DCJ+kczIltmw3Ejp1C1KS9y1tUUG0xl7hItnhmtFL7nLHY+tH
         BNzowYJ2rCm8CmM3VTK5/lyMCM6QxKeqasL/rOLwea8/g6DP9O5ujCakOs0gi1TS9srL
         JQbhh4l2+YhCLt1l+rkRk9fcqalXZN2KWtE5d26Q3TlPVj3/gk1qiZeok8OO7t4lWSDJ
         eWljwJfce9+wCvC1owQYHKJWSEprY/WwLPr7VD5fEByWwG6YNcnZwTSQ44DiwhnzsZMw
         54Q5GPD6XMexPK76rcOLqWATzvqerAVEUNMCP0KWPXc6swx7JYqyPVQfqo0GoNx1Lcrq
         cOjw==
X-Gm-Message-State: APjAAAUW5Se3CMVtJVSK/ydmnN9f4x/jsWkrxLx3AmYuyoCo2HV/AkGA
        of8o+4JkXnb2PSHGQps7aO2hm5r+lck=
X-Google-Smtp-Source: APXvYqyZvI+sDh1pbkEyOiwerf4WV3TlzNFp5KSS2RYeZLJAgrl1uZU+4vkY2N7Xk/0H6Rxfk26xNg==
X-Received: by 2002:a50:ace1:: with SMTP id x88mr40609308edc.132.1571877271543;
        Wed, 23 Oct 2019 17:34:31 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id t24sm207246edc.56.2019.10.23.17.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 17:34:30 -0700 (PDT)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Boaz Harrosh <boaz@plexistor.com>
Subject: Please add the zuf tree to linux-next
Message-ID: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
Date:   Thu, 24 Oct 2019 03:34:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Stephen

Please add the zuf tree below to the linux-next tree.
	[https://github.com/NetApp/zufs-zuf zuf]

zuf is a part of a bigger project ZUFS, which has a Kernel part and a user-mode daemon part.
The last mailing-list submission was here:

	https://lore.kernel.org/linux-fsdevel/20190926020725.19601-1-boazh@netapp.com

zuf is a zero risk code drop into a new fs/zuf/ directory. The only friction part is an
easy merge fs/Makefile, fs/Kconfig && MAINTAINERS

Here is a short summery from the cover letter:

ZUFS - stands for Zero-copy User-mode FS
It enables a full implementation of a VFS filesystem. But mainly it is a very
new way to communicate with user-mode servers.
* With performance and scalability never seen before. (<4us latency)
  Why? the core communication with user-mode is completely lock-less,
  per-cpu locality, NUMA aware.
* True zero copy end to end of both data and meta data.
* Synchronous operations (for low latency)
* Numa awareness
* Multy device support
* pmem and DAX support

The Kernel code can be found at:
	https://github.com/NetApp/zufs-zuf zuf

Project History: It has started somewhere in 1st Q 2017. And had a few incarnations.
I have presented this project in all LSF(s) and a few Plumbers since then.
It is already released to Netapp costumers and is heavily tested daily. It is very
stable as well as capable and preforment.

I expect some more reviews and one more version posting before I will find it ready
for upstream. But I would love if it can sit in linux-next and make sure there are
no surprises and properly compiles under all configurations/ARCHs it should compile under.
And that it is really zero risk for the rest of the Kernel.

The above *zuf* branch is currently based on v5.4-rc4. And cleanly merges over last-night's
linux next tree. I will keep it up to follow latest state. I might rebase it a few more times
to merge in fixes and add more documentation.

Thank you
Boaz
