Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E164723B489
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgHDFnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 01:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHDFnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:43:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B30C06174A;
        Mon,  3 Aug 2020 22:43:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so2760295pgi.9;
        Mon, 03 Aug 2020 22:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opizXqAmsRO4EtJdKZFFyzh9erOA9+JY3GTU/QHYgDk=;
        b=rQCZxWU+iptDfciRqydWseMplSG3NKGzlIRXbuPdcwL3sTk+CoRMCB30SEzVae7M60
         o5lP+0GV025EYyQqWq9iDvnG1cImAVpQK+ElK5t/wx4KsjWklboCHRcI1JEmv6vtIFHA
         eXTWvJQtP4KZ+Y49S2EPNo8qjLPbFw/T6Z6phv1r/k2DRXY7yuYVb/VTfAKA8SI5igbv
         I+TbV/e3E5CR7vH7e/qcR9T4L1Qk1NPe/dQzW6i/h5thxTCJbodFDrONRaK11oqvGf3U
         kGvHtOrHWvBTHciuGBv9gk0p8qGjhuMN531Sp6GCnUvryzqVChL7pHYrS5eDTnfPa8IJ
         otnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opizXqAmsRO4EtJdKZFFyzh9erOA9+JY3GTU/QHYgDk=;
        b=ZuypHvBFOY3s9dnPfLllv+RQ0lMwtduicQoTOTmqth2vtiEbUjkt/rJB2It40HAqAb
         tVwM84Ec5FTGHAIoFVNAws2d/513d0aMDfR6QXPQDsJgrdUcNVQuZHCIDjxVeGPVBYYi
         jZQS76oWuOECliTwN/ySRJ4IHnoeCuFfMaF8+/gwUkNmw7Ge98u+I1f3e1vFP29RGFTL
         Whv2qdeVnTt+Q42wqDS+7B4a3eHpp4we+siPR0/u49+mDDEo9xFupT3yhH14DI5vAtYN
         BpriINtjJ0iZ9JDmHwINlE0i/z+6lZmbDWqIxzpVozlFFWTkUXmjKeO02ajDcJ2KVOGz
         rIPA==
X-Gm-Message-State: AOAM533UYe8zYXLcN06SMCi5rZb4tfsQkYNN4kUqnB6BEFffiih7E7OJ
        0nPdV4edQCu1dJtDUjTVPqk=
X-Google-Smtp-Source: ABdhPJznfkOeR7KzT2yv9o6vG39B2pOmluC3VlXdKQF/mn+UWtwESiWkdYyKHYBit8tTPXgXeQTKvw==
X-Received: by 2002:a63:ec06:: with SMTP id j6mr14109864pgh.328.1596519796146;
        Mon, 03 Aug 2020 22:43:16 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id z2sm7379100pfq.46.2020.08.03.22.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 22:43:15 -0700 (PDT)
Date:   Mon, 3 Aug 2020 22:43:13 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200804054313.GA100819@gmail.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 06:01:20PM +0300, Kirill Tkhai wrote:
> On 30.07.2020 17:34, Eric W. Biederman wrote:
> > Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> > 
> >> Currently, there is no a way to list or iterate all or subset of namespaces
> >> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> >> but some also may be as open files, which are not attached to a process.
> >> When a namespace open fd is sent over unix socket and then closed, it is
> >> impossible to know whether the namespace exists or not.
> >>
> >> Also, even if namespace is exposed as attached to a process or as open file,
> >> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> >> this multiplies at tasks and fds number.

Could you describe with more details when you need to iterate
namespaces?

There are three ways to hold namespaces.

* processes
* bind-mounts
* file descriptors

When CRIU dumps a container, it enumirates all processes, collects file
descriptors and mounts. This means that we will be able to collect all
namespaces, doesn't it?
