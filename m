Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E416E1DBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNIGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNIGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:06:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB440F1;
        Fri, 14 Apr 2023 01:06:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-247061537b3so440400a91.2;
        Fri, 14 Apr 2023 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681459609; x=1684051609;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pDgMY2uf/2OwQImclTx5thTOqS4qhcATXLrvKTp73M=;
        b=WdcwNeQ8p7OOQ3fvo5SsWtk4XH60b1j5QjdLzpHuCqAh+CDAplMzqEMUoa2lY25Fc9
         O4hlLybQN8ScVYHxemwTaYMmPjoFLy/QDERP6Z8hvK2wHo+2b+MATLcDbiOWGqA4OYeg
         Zd/P1XAJXZ9xiXBHLqmL70Q3kwPgdqsBR/4Muno8T8cNRFMpdafRtsRONEtntTtF00p9
         QAlvEHeNriSIRgOjzhUs9ewMs8xmqPhPbm3DbRE4uIOhxvGnHtnFcvXEaVTJrrIriD6e
         nn3RZJx4TIT4NmCg/lEFESkyUQUhwhlvGXdcOseuLjhhBX61RWPB+F20cI1JGof/euzZ
         KDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681459609; x=1684051609;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pDgMY2uf/2OwQImclTx5thTOqS4qhcATXLrvKTp73M=;
        b=bF2eIp6bS234CowtRTyen/RKD82SlXba6KfwqXbV6v/AZfV1w08njtxx3I4Wagc8QH
         YKINJUZvrmLFoWSZ0Xd5swpWxizrwtjoFtfATxF2WrY1QjFliXAJKige5LbTbprDHlII
         pjeLYPMxscFYMgcisoTHhSrQ78ux6GHzbDq4x0/nZYU+p87I6MJ/UMbL/8PTt02iEhsz
         HRKfI8igEG0fWPzREV+zjICJ0L0L1GL9XKimwUTD9nwAB8lPcVF7BMDE4FUO3ZuNK9Ko
         4b6Sgmj0ArrYn5jqy4/QDgA/ky7fQwyepYFef9873iIagqi8LMzc/tTNIkBsnEmpZJk3
         ingg==
X-Gm-Message-State: AAQBX9edqWzK6fDm2ho3lJvYivVZYKcOpOIRgjujyNIkzrgBdYFDHlMD
        mnTdKF07Pfwx6iOb82DhjWbJz/CEzlA=
X-Google-Smtp-Source: AKy350bsfWLZFDdR47Dmv3nwFRakreRIiCzXJwhp6bWE18W7nr8979KbkVHKPGpmmh1ZT82rTs+orw==
X-Received: by 2002:a05:6a00:1905:b0:639:243f:da25 with SMTP id y5-20020a056a00190500b00639243fda25mr7031703pfi.22.1681459609382;
        Fri, 14 Apr 2023 01:06:49 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id q11-20020a65684b000000b0051b1aef8032sm2464157pgt.38.2023.04.14.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 01:06:49 -0700 (PDT)
Date:   Fri, 14 Apr 2023 13:36:43 +0530
Message-Id: <874jpizy3w.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 07/10] ext2: Add direct-io trace points
In-Reply-To: <ZDjr7tVpeOWaW44D@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> So why do you add tracepoints in ext2 in addition to iomap?

1. It's very convenient to look into all ext2 filesystem activity by just
"trace-cmd -e ext2"

2. For cases in ext2 which fallbacks to buffered-io routine.
Adding a trace point specifically for ext2 can cover this path as well
as to how much got written via buffered-io path or in case there was an
error while doing that.

3. As of now there was no tracepoint added to ext2. Going forward it
will be quick and convenient to add any trace event for
debugging/observing other call paths too while development.

-ritesh
