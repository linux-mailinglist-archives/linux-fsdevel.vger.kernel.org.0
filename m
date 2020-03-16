Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855711867CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 10:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgCPJYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 05:24:51 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38704 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgCPJYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:24:51 -0400
Received: by mail-io1-f45.google.com with SMTP id c25so15741340ioi.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUYs1XygfkPWhXBzC0i52h/D2pYMdOVUODcYnrpTX78=;
        b=OVdkA0aIWOR2avsUQ4QE3bmo0btAYOuJSJea9Vo64Ivdfpu/whRWiB36eCQz2LfFAH
         dcHY70c9i7v+KD0PnEGPoKZJgOvKJL9Jn6d4sfm6kptqbmZzcw+KikRDtCSI3f7B70XB
         Yg4hNg5E8KNrsrO4YaQ122IEQEPzvKtB0j7Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUYs1XygfkPWhXBzC0i52h/D2pYMdOVUODcYnrpTX78=;
        b=BchmyUMdXqOFpIABIAssg4YTJZNa3J511jZaCwTDzbYrLLKWNjHcxDRCkZMNr2omaS
         jRy4ZXCjyT5UrsEV18eagYa22xPUlCq8pTKY13aTKS87QDj7mFBLqVXc+0oA06DARz2P
         HmVPebHE0MZ7PtO/pffs97k/ep0WOhKECRRAKhtlisR7/o5YyXjcZghP7kHUhNP5A3vJ
         GxLSwlOUZVCPn1MP3POkSHWYc/kcVdyg7Vtsg/3MN1wJLJrregl8AKRad66ODqWipj3B
         2sdmHJip+uzn1XR73tfPVsNQaWLRWso0aJJhImwRGgnodlt03/PAOnO87jDmvJ6sTgx+
         0oUw==
X-Gm-Message-State: ANhLgQ3w3mSX115HG1VZFtplplVKV3iuVwK05beJtMEpJY1CwIBu+D/i
        TfglfJqJRC7wiZqUbfDCJXcx/cYcRmPlFFNjFWOW7g==
X-Google-Smtp-Source: ADFU+vtE+ICO0NdzpDTUnpJxlcmp10PDuQyr9SWqBAWiUXWGyC27DPfjyC0SBj2DLsS3Tj0XFAu8FDWijepfHzzgpNc=
X-Received: by 2002:a6b:3944:: with SMTP id g65mr7426972ioa.78.1584350690128;
 Mon, 16 Mar 2020 02:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <6149dfe9-1389-ada6-05db-eb71b989dcb2@huawei.com>
In-Reply-To: <6149dfe9-1389-ada6-05db-eb71b989dcb2@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 16 Mar 2020 10:24:39 +0100
Message-ID: <CAJfpeguDOYvNRuFg3UNVEnrfbvf-VAhO_bJ5Gbjei9X0gwvJaw@mail.gmail.com>
Subject: Re: [RFC][QUESTION] fuse: how to enlarge the max pages per request
To:     piaojun <piaojun@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:03 AM piaojun <piaojun@huawei.com> wrote:
>
> Hi Miklos,
>
> From my test, a fuse write req can only contain 128KB which seems
> limited by FUSE_DEFAULT_MAX_PAGES_PER_REQ in kernel. I wonder if I
> could enlarge this macro to get more bandwidth, or some other adaption
> should be done?
>
> Up to now, many userspace filesystem is designed for big data which
> needs big bandwidth, such as 2MB or more. So could we add a feature to
> let the user config the max pages per request? Looking forward for your

Currently maximum 1MB per write request is possible by setting
FUSE_MAX_PAGES flag and max_pages=256 in  INIT reply.

Thanks,
Miklos
