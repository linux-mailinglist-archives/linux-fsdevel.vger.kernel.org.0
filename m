Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0810A500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 21:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZUBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 15:01:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41579 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfKZUBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:01:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id t8so8553152plr.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b4nMYyMZLdJTu1lsp2vJ7LJSFFbPniRCr7vgs74sWbM=;
        b=jCteqbHZIlDVKF77LxJogeNq0ChJQpDzdTb8SfTvrCSoky7CKHFC5o66x3Zac7V8Le
         MEUvAWyMsK6FMcJCKQtGwCCokHpV3OerEo8C0oirA53k+b4rVilYguFTDSJhQZ2Z+neu
         gzViq+zCV8nrResRpHBZTSyXMgC+g7NoK4DFuziDj56v4GXPPhtTczkSSEmUPDWPpMq1
         2mRCJTWA0J/IOK9OqwV9LvDqq47Cu99zA7MaT9Symp+NotD+Yg+yHhdlNFtD7EcwQ60z
         tcXHCUfMGMxyqC8l8J7MIGI5P7js1NCrFu99jSix84tf0ba9h0yWl7xRB4lx81SK8YMM
         qpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4nMYyMZLdJTu1lsp2vJ7LJSFFbPniRCr7vgs74sWbM=;
        b=luFPregN1PesffF13sfr8oRUMuJu9K3YKvpxxDcSXfDJlu8etpttTNBJ+AA0AUZbDK
         jxZHrWz1N7zZE9gpFVc6wyRexy+gaRQrnvm+f5Fbkk6s/mF3ofTl5wncyyjysZRVv1P9
         GSm02c4t2RIpcRueqO0X/MnBO7Lfu0/WA0s/O0sKIrBpaXNV208oYQhUy4ynT34mQqgE
         /cq8xKdM3gRsLFExWYclw3t8vxDIRlL1VqzZR5AqIejvW5mT2RDKYgYDiSmq40pzhupd
         Zw3tcpq7HAI72fTSYX85r4Dfijt7K7Mj8E6MAcrFzXgFz3tO7/Im0N9gTj/f/6o6M08E
         rFFA==
X-Gm-Message-State: APjAAAU+fjhT/Jy1JlRk59WjmG0SRmd7JljZjYqCs4cTbm7wbL6NiDZ7
        c7TTU2NPIJ/W99dPe/MSA/b9+w==
X-Google-Smtp-Source: APXvYqzxZXjLZ+Y0q/kzUzpcJTVYX2YMUaQDISq6yRH+d/E+Tl5Yhl/S5xZe/N5wi80C6h7C9sLD+Q==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr105469plr.154.1574798506461;
        Tue, 26 Nov 2019 12:01:46 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u24sm13371114pfh.48.2019.11.26.12.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 12:01:45 -0800 (PST)
Subject: Re: [PATCH v4 rebase 00/10] Fix cdrom autoclose
To:     Michal Suchanek <msuchanek@suse.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
References: <cover.1574797504.git.msuchanek@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6fe572c-530e-93eb-d62a-cb2f89c7b4ec@kernel.dk>
Date:   Tue, 26 Nov 2019 13:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/26/19 12:54 PM, Michal Suchanek wrote:
> Hello,
> 
> there is cdrom autoclose feature that is supposed to close the tray,
> wait for the disc to become ready, and then open the device.
> 
> This used to work in ancient times. Then in old times there was a hack
> in util-linux which worked around the breakage which probably resulted
> from switching to scsi emulation.
> 
> Currently util-linux maintainer refuses to merge another hack on the
> basis that kernel still has the feature so it should be fixed there.
> The code needs not be replicated in every userspace utility like mount
> or dd which has no business knowing which devices are CD-roms and where
> the autoclose setting is in the kernel.
> 
> This is rebase on top of current master.
> 
> Also it seems that most people think that this is fix for WMware because
> there is one patch dealing with WMware.

I think the main complaint with this is that it's kind of a stretch to
add core functionality for a device type that's barely being
manufactured anymore and is mostly used in a virtualized fashion. I
think it you could fix this without 10 patches of churn and without
adding a new ->open() addition to fops, then people would be a lot more
receptive to the idea of improving cdrom auto-close.

-- 
Jens Axboe

