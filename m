Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC973ABC42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhFQTFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhFQTFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:05:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74959C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p66so4306195iod.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UugQgVW7y2l1Fd0bXWMxexDacdGVqms0JU0lMpf9sbg=;
        b=fb5mHF6lay1zJuE3cxKy3HQgFj7cY3+LZQdZDbYWI0eBTb6Vcx7uDqLW8EGLa18BV+
         SzW8sL/09rVKNfVucmT+n+JVjQ8R+xUkjVhQH8NVYTwaYUQzDOWEgL5UoQ5+VXr24pJA
         GUueuI45S9BTAUpTckOi6zm+OAdBjCTH3862o6fZBeROVZcOgpNl8AcIgh78sADYW0iS
         9Aql4n/xr03ThGPg2lzjxuhLx1pAT6fRr1/6hZPy0bgFJl0Ek90Ry2H6ZQP8RIMTV7SJ
         itZKQmBYaw+MGO3EHbCr4GagG/1LXQRG8lImHGJjX8/C/kIeo69looPup/UXjNVOb1MW
         /f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UugQgVW7y2l1Fd0bXWMxexDacdGVqms0JU0lMpf9sbg=;
        b=RsG/OMiA16SpfMCEURJaARlKXClYOiXMbL7SLld0b43OXv3FsjsS9gV+4SLErvaRbu
         kec3n8yJ/x007VM5K034fzMuVqM/uo03Krcj7a7maOs61CL++GgwmqhiDm/jnbH39N8h
         TdvpeUsuYXKMCJUOeYn9Uwxo8C7LG1/pR8vXxpAp80gAxJfs43zBU/Nn3QEpzNBHQu2/
         MfhcB8avNnsKAs5uWSXRPLN6q1VYKplXQ2xGtxZL+5rkJDoRYVF4QT2A7q2m0odHnvnv
         QlC+mQgoJaua+E4Cgt+k82gjAwYj7E5BXXBETNKPq57iziz+qhH6Zf69/ojn7l50O5d1
         yrqg==
X-Gm-Message-State: AOAM530ltpjaSOy9BhPDLZz6FHRffXRv8+pN4JDmBqYI29kPKPKejCoH
        B25QiJdjfZRVAj+AWQWEyOenN7k8/hyCUzLf
X-Google-Smtp-Source: ABdhPJwPOMPFG9lb81CMJviWhGdJ+rLxTPBEG1++ydZ5uxgVcUy7TP1xSRCQzVYQkP50imKDu2I++Q==
X-Received: by 2002:a05:6638:2707:: with SMTP id m7mr6060419jav.66.1623956602702;
        Thu, 17 Jun 2021 12:03:22 -0700 (PDT)
Received: from google.com ([2601:285:8380:9270:9b02:154:406f:ca4c])
        by smtp.gmail.com with ESMTPSA id n10sm3213390ilk.13.2021.06.17.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:03:22 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:03:20 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/2] tests: test MOUNT_ATTR_NOSYMFOLLOW with
 mount_setattr()
Message-ID: <YMuceKiSIG1tu0Gw@google.com>
References: <20210601135515.126639-1-brauner@kernel.org>
 <20210601135515.126639-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601135515.126639-3-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:55:15PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Add tests to verify that MOUNT_ATTR_NOSYMFOLLOW is honored.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mattias Nissler <mnissler@chromium.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Ross Zwisler <zwisler@google.com>
