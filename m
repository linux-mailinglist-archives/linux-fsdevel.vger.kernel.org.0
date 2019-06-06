Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29FB376D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfFFOed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 10:34:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43160 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbfFFOec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:34:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so1609450pfg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uliRl25tF2O1ExnxNI5OeemcUVuWp/hZHc1pbbwUvtw=;
        b=MBprUpp1e5VKUe+T74LmM6i0Ek4WwUD8SNxviqye9qRCXjeQD1AN2cQwMjMeLOJAFU
         gJe75uGQWbYYHmyw2x5BvtU5ncrcFbkHTESEAOA1dzwscKIbkZKdQNpmnqFhKnBmc3zQ
         EGOBnm10P7Akkmw3M7Phxq/g7hqCRhz0eQ+B4qicHZCKeanltJAA1IX5vvqIsNB6EU1V
         ffagFv4poPie3Oi6fc6m4FO/7bfLmtOyca95WSoReHg1f/VgYW1TP1sk+8d73DWcuplv
         eVzc1ya3v/2UecxqoJ+Sq8Lb0zxNK7qHeBb63mjflhEmiQno3Q0gxTPT2+o1bJzLxiLZ
         ZnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uliRl25tF2O1ExnxNI5OeemcUVuWp/hZHc1pbbwUvtw=;
        b=BbI1qrF8il5VO6HTiikI1YGqyJtW0N4qSufMd/19801SvVIi5pS85iVIrWAUR2xTs9
         UaVUCTMGaGLOjAvRR3H82RmHfaF37qjuztczCBp1nCuNmk0kRFkv0VGW8gEIjCMUCkN4
         37uRbQyXazrPErL0y0J4+Pz6Cxz15ORh4P+dKP7j0v/RDooVTvlf6VtxvLks0fqzuoS4
         Km/JaEMQ67AkgmW6xRxNFe5Kah0FFMPAa0KpD478FFt2r9Sq+2NZMcBlR0JYkxqxKiTp
         K6Tm9RhExQX5rdZChamv12l5LvVUtD/P5totuRkvGhD91bcthSaMFHWO4ZkI+luhx8Xe
         +9iQ==
X-Gm-Message-State: APjAAAVbB2qG7Ej0Vdu4/ACQjfGcD/EhsSvcXQr7sE71jgOxOD+ardAv
        R70IgwchupMI4vmocxg5SwXU2Q==
X-Google-Smtp-Source: APXvYqzIL8wsldD4bies6ebY7rZKopPTvKboOK8nOCrGaFcXy8cI3glqwYs+CwKGEY8yNiE0aUv+Rw==
X-Received: by 2002:a63:dd05:: with SMTP id t5mr3525537pgg.229.1559831671810;
        Thu, 06 Jun 2019 07:34:31 -0700 (PDT)
Received: from brauner.io ([172.56.30.175])
        by smtp.gmail.com with ESMTPSA id l7sm2552259pfl.9.2019.06.06.07.34.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 07:34:31 -0700 (PDT)
Date:   Thu, 6 Jun 2019 16:34:21 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
Message-ID: <20190606143420.hxjximmhigpa2nti@brauner.io>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:41:59AM +0100, David Howells wrote:
> 
> Hi Al,
> 
> Here's a set of patches to add a general variable-length notification queue
> concept and to add sources of events for:
> 
>  (1) Mount topology events, such as mounting, unmounting, mount expiry,
>      mount reconfiguration.
> 
>  (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
>      errors (not complete yet).
> 
>  (3) Key/keyring events, such as creating, linking and removal of keys.
> 
>  (4) General device events (single common queue) including:
> 
>      - Block layer events, such as device errors
> 
>      - USB subsystem events, such as device/bus attach/remove, device
>        reset, device errors.
> 
> One of the reasons for this is so that we can remove the issue of processes
> having to repeatedly and regularly scan /proc/mounts, which has proven to
> be a system performance problem.  To further aid this, the fsinfo() syscall
> on which this patch series depends, provides a way to access superblock and
> mount information in binary form without the need to parse /proc/mounts.
> 
> 
> LSM support is included, but controversial:

Apart from the LSM/security controversy here the general direction of
this patchset is pretty well received it seems.
Imho, having a notification mechanism like this is a very good thing for
userspace. So would be great if there'd be a consensus on the LSM bits.

Christian
