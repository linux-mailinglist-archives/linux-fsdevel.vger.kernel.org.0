Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113C748F489
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jan 2022 04:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiAODLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 22:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiAODLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 22:11:53 -0500
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com [IPv6:2607:f8b0:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E82C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jan 2022 19:11:53 -0800 (PST)
Received: by mail-ot1-x362.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so12322663otu.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jan 2022 19:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:content-disposition:user-agent;
        bh=plSwlEbLO3tG/wv5pbnbZDWr8mlodkQb5tRKykFZF3c=;
        b=uD3gyC1MzQhiVLRILaY2HZ1Sv2HuFe5rx473JMtV3w4CB7+mNaP51+LixISiWG6ttN
         NBnocKO04N8rE/+HKV3aVXcgNaU4u7sf5VaUx1DXeJgj6B4VuNE1Gy+nJrgFL7LrDsVB
         993Gp6jptjhsPfjuwhlNClBzjR7fbYy/UL6rdhoBWr9BXXkjJxEM5urTtp0MlspQi2GT
         fUkHip1+NDv3nj60NbACHbTjprMe8g0YiKw28F+oNys3NbwnCwPsxqZVpwX4RDPdYwey
         afIsBdI0AWEC91Cd2IIxo7QeZKS0SzM7/frxUHUFHkotHMh6a1URCBqcMVM1yfYqvuqj
         mqFg==
X-Gm-Message-State: AOAM5312My6+LeMroGHXSAokpXn43dbhVrPvkzhZBTyuT0ZpgW+RS6qc
        SUSy5x3KBTD8oOdztG2yXKd6bDRfJv92qTI2YTpvmbvWoh0b
X-Google-Smtp-Source: ABdhPJylK3h0tJWMbDrjA/V/n/5gEBHMtlV5iyqgIqnsoN8vJhyPTDOOQeCYjgqvgKx5V3HJRM6HlbtPkdIP
X-Received: by 2002:a05:6830:1e37:: with SMTP id t23mr4884926otr.160.1642216312808;
        Fri, 14 Jan 2022 19:11:52 -0800 (PST)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id n91sm1666021ota.0.2022.01.14.19.11.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 19:11:52 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from visor (unknown [10.95.68.127])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id EB486402048;
        Fri, 14 Jan 2022 19:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1642216312;
        bh=plSwlEbLO3tG/wv5pbnbZDWr8mlodkQb5tRKykFZF3c=;
        h=Date:From:To:Cc:Subject:From;
        b=t4fFQfDd+jg6sRh+kZIXaqOSmSj1zRUaKl4+xo2R0AyFUvAlMTOz6sHc4EFrQoMyM
         BTxagJZ28jCZLdefSUv+TvzQwfNCa1khzAOkx+TnAyUM/4whRNQy+7MK1JCoq/hO1f
         5TNl9Eq/XZoKd9UKJJGYYKwZKMhvF+IggzGj1s5d8eX9XYwGLkR9EciwjacbyZWbsO
         XArd8zBNwxkR7Z5nMHvaSLBZklDOMFcq/hN4TXH+YfXai+APrI3YQJFMdOqzT1hK64
         EUJ+UQCeqe8ILq1Hgu8dsHmyE3l+L8zGLfgauPPnhSzEBgkKRGl/V5sUcWe6ZckN6X
         zE2v/wtKG/wXg==
Date:   Fri, 14 Jan 2022 19:11:50 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Potential regression after fsnotify_nameremove() rework in 5.3
Message-ID: <YeI7duagtzCtKMbM@visor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry to bring this up so late but we might have found a regression
introduced by your "Sort out fsnotify_nameremove() mess" patch series
merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
reproduced on v5.16.

Some of our processes use inotify to watch for IN_DELETE events (for
files on tmpfs mostly), and relied on the fact that once such events are
received, the files they refer to have actually been unlinked and can't
be open/read. So if and once open() succeeds then it is a new version of
the file that has been recreated with new content.

This was true and working reliably before 5.3, but changed after
49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
d_delete()") specifically. There is now a time window where a process
receiving one of those IN_DELETE events may still be able to open the
file and read its old content before it's really unlinked from the FS.

I'm not very familiar with the VFS and fsnotify internals, would you
consider this a regression, or was there never any intentional guarantee
for that behavior and it's best we work around this change in userspace?

Thanks a lot,

-- 
Ivan Delalande
Arista Networks
