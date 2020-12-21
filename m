Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC12DFF5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgLUSJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 13:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:09:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5BC061793
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:08:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o17so25875959lfg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=strato-de.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t3QVggRzHjEFtsFh1wMUe/+tpa2QkqZwpikhDdpwCpk=;
        b=XOgNKnwZHTOihgKI7ehiX3fYVKe5IRebLCVuwmkhanBXJY/bsWZGPLLIAI60cA9tl4
         c3hLwtce33nIkNeAIvdxQJ6hGG4fBNz4+nSXOLIMpXDckhxq8nvRNULFenZdMn0HfzMT
         IZfDffRrO6MMLKwTcWGVBXbGrXWw/iDux/JEjVzOnZP5L6eQ4dzJIq6hoYeCnkRwcrXM
         ndlWW7r11vhmYBvSQtdbo6DNsYCi2yPYupBPoEQnx+uzB62ZZ/IWwN26qOo18OTztc8w
         6Cy/sNrymIIVLOKMQMU15Kr22Z+wjTXHmgq9eyUsag0KJjUcgoj4Do+qLtYdDNc/gUJN
         hy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t3QVggRzHjEFtsFh1wMUe/+tpa2QkqZwpikhDdpwCpk=;
        b=N6leEiM8oSMolfmdJvL0HjcnlTAjzDWDkqmkYThJca6pTaGXWe67VotUdEQsJLmCwy
         t7O+6RB1JfZYhLenuk17fWtR4R8NdEz/K9RH2wrqfqrF3iph757DibZBzSdU2I96h2CH
         iQ4786FCc8WdaqvZAl2UsSoRUeUoB1RVqGmQ3iMhfTg7ShwE6Sm3BP2snrWZGb8ZWQmg
         JVdxlflqgrSRz97FY8QbeKnoDE9TDZRlZZuiIqZT0wK1DgeSng9WTXcUoPHUfW8HNV36
         vmrV5d2CbS3uWCWietO0E1AzAiefyqSJViyewDfIhkloWOzk6LUvRqOxiEfO+qWIkoic
         m2sQ==
X-Gm-Message-State: AOAM532pec08Ovi+XmTAYYj/RXN02fk76Bq+jrl2ZG7Y8dCUPRCLhXj8
        zS8Gx3/SsTxBgoCzAGhUHVjrg/XtU6qxyK3N6DvyMIOhje8lkeWDRBwTRY01u2v/3Xw5UEGPaK6
        UTFJlKK+r4uhnoMlW6BFXTb57V1vPHkaE6TrB4p0CP/3Vs3MWWkRS1FdQjjpsZl6By07+k44NRL
        M=
X-Google-Smtp-Source: ABdhPJyIc8q8dP+FTuDSz47zMwtcl45+Vt3lQp2do17dp2KtZNcqT6ykvMA/2Iv8IsapIXMvpEhkyQ==
X-Received: by 2002:a17:906:391b:: with SMTP id f27mr15898532eje.195.1608572293077;
        Mon, 21 Dec 2020 09:38:13 -0800 (PST)
Received: from [192.168.178.67] (p2e5a4655.dip0.t-ipconnect.de. [46.90.70.85])
        by smtp.gmail.com with ESMTPSA id r11sm28650492edt.58.2020.12.21.09.38.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 09:38:12 -0800 (PST)
To:     linux-fsdevel@vger.kernel.org
From:   Barnim Dzwillo <dzwillo@strato.de>
Subject: [ANNOUNCE] wrapfs with support for operation on top of NFS
Message-ID: <76be1b65-3e46-ec09-45c0-db3a640179fc@strato.de>
Date:   Mon, 21 Dec 2020 18:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

A version of wrapfs with support for operation on top of NFS is available here:
https://github.com/bdzwillo/wrapfs_nfs

The major additions are:
- support for remote file locks
- fixes for operation on top of remote file systems
- example code to wrap vfs-write-ops in a separate branch

Since the original wrapfs shows its age, the lookup-, locking- & mmap-code
was simplified based on code from the ecryptfs & overlayfs kernel modules.

This version was developed for a centos-7.8 kernel and NFSv3 filer mounts,
because this matches the setup in our company. I hope this can be useful
also for other environments - the centos vfs api lags behind the current
vanilla kernel, but the internals are very much alike.

In retrospect I must say it is really hard to get the locking right on the
vfs layer. Perhaps it would be useful to add example code for a working
vfs loopback driver to the kernel source tree.

Thanks,
Barnim

--
Barnim Dzwillo
STRATO AG, Pascalstrasse 10, 10587 Berlin
Shared Hosting Development
