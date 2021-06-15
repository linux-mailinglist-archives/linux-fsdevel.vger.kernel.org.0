Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB413A89E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFOUD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhFOUD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:03:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA4C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 13:01:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z8so19609603wrp.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5yY14JY0obd4qDg+m62BDv0Y25d3kDiU0Ux4Pv/8/ZQ=;
        b=jFK5xgAiAliNHZRQpllWFBHEi/WvHTXLcWF6Lvs073AMl62xCEGvDgcdAQHG4pSLcT
         YwzzOkOAODaQmUc83hiS5FCW37Fl5cnCNQRDOf5XUMsGLFn2V4MzlVqsCJC6oQ4tVqZf
         quEggTRVmu+NuWtte4+ECOAf9C56B1XFSdezyR93MXI6IuNShfVOhH3hL02/+qP2JLp8
         K+K0HEwhZjxH28brNGPJI6cHcuwOXcD5XlQFGH0v+Qf0owbWAaceOiPfz81OcJPBz8iv
         5t9rvY9WgxWT0s6ishFTk768DbPgr7n8OGPEn5cs8+GVT9WazYJCuEkEgdp1DoThbK6l
         6sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5yY14JY0obd4qDg+m62BDv0Y25d3kDiU0Ux4Pv/8/ZQ=;
        b=ag28v5VdIkW75KcxcRhb8eS+eVyAHR/HctcxPoEqearkLDWBlGRcnrFsOR2KWiUo2U
         DvTaQMdnY4OGK/aiQdNQuOaE8ldWX0pAotg1I8i71Z+qYVT9jpIKzdwQqO2z+ozG08yO
         /ZWRMCJeq1psWiybC2Pw6MJGWyYBKgv45LjSiJZyOOzPmPnjQEiR5Tx/byyGnCV6nQrQ
         FSPFPQUUYXxm108HN1hs0OEv7m0fxeAUlkdxp/3/047X8BTYr2rBtHmv2Q8erL7xnniK
         Xpp5Q+1xwwzZ2prctma8n+j14DW0p/Nf9sEF4nMcpKGwKZs4cO2b5fSw3Ouiq00dn40U
         U6kQ==
X-Gm-Message-State: AOAM533mNhGyPw4Dx63Hxz7O611Y5QnutKmxGYGISbwOHHcIouIIUC6Q
        +Zv+IApYPXThg8gyV+Vjgp+WLt2PdbsPSMIxfJCA+JyjGjs2
X-Google-Smtp-Source: ABdhPJycln1x8xLSqqUavUj5d/8H+AQbl7y6d4ei37CvqIeXHBmmRkaVjnSiCdjXWOgW3V6LrVoHjGFsHodfBFn6OJ4=
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr984709wrr.26.1623787311941;
 Tue, 15 Jun 2021 13:01:51 -0700 (PDT)
MIME-Version: 1.0
From:   Stef Bon <stefbon@gmail.com>
Date:   Tue, 15 Jun 2021 22:01:40 +0200
Message-ID: <CANXojcxGPS-3CqCNx3MuwtHBsu+tD2RFWszD7qcRMn2wZkANZw@mail.gmail.com>
Subject: Tests available for list implementation.
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I've been working on the implementation of a linked list, and the
basic operations on insert after, insert before and delete of a list
element. See:

https://github.com/stefbon/OSNS/blob/main/src/lib/list/simple-list.h
https://github.com/stefbon/OSNS/blob/main/src/lib/list/simple-list.c

I want to test it and compare it with other implementations. Is there
such a test tool?

Thanks in advance,

Stef Bon
the Netherlands
