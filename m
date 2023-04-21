Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333236EA9EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjDUMGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDUMGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:06:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE849E1;
        Fri, 21 Apr 2023 05:06:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a5197f00e9so18529535ad.1;
        Fri, 21 Apr 2023 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682078762; x=1684670762;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZY76Pb6VbO97poVQbCL5nK5VULYA5G+gSgygdES392g=;
        b=Lg1JnyDRjFXNM29Kyd1u7QWwm3G4a+ahGN+lbOKhuI09wc9yPu2DJ2m+OSCOPfj1c5
         9L5HqMRxL0E3UsDkrqNhv3Fk12+GXItAzaDFfp7ovy3cE5ZAg/8PDsYjZQhoHsnrW6Ly
         N+aF6Omay8hHMk8bgz/GsekESA6ca0cZgXi6cf8KdUFkcM9i+FDjbQK+jjeZn8IsLD8X
         mffSh332gvEaEYEVaDEbQxcqRyK/jIhSWeK4rrLaox31512x67yT1dGuRlCMHc4cpMhf
         3xuYPY+uBLm1+OsInxyT7RNwnTPB4UFPim2m4GPJzPHQ9FUjKDUOdaeWH9FRiq1YgflC
         qKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682078762; x=1684670762;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZY76Pb6VbO97poVQbCL5nK5VULYA5G+gSgygdES392g=;
        b=ESJz5jOEHm9WfyNXSpbHV1TR0srrzvQb5KcPjXZLgaNFVymrM0/y70mXpgRP/lRs/r
         oE6U38znVGfUw7Iqt3CdvwE2BAgXSaEm+xuznFnj6y5Bqb/19uNBJqoUy73UsjfI6rJC
         p15UcMbxPaAvZ2Fe89zkExynkv2WIXh1bHfvtypWhON5sNenTpOctO0vAqpAif3XcNBM
         fdLRnhtKFUWOOmgRghaOihhM5diQTDlKJHdpSBsklVqYtfLNVhNpnt0SZYGiXe8CG8DP
         lFXyydrws3ajt4snUJmM8skfmQJZLNKzF3iBHf/055F2B17ELnGiTtrJg78VMI8JKH3n
         WS1w==
X-Gm-Message-State: AAQBX9fRnLEKSIT6dvPH7ZK7l+O9tVPWUUYzQmCfsE14Q0AdHPIoDlRz
        Z0nhIlXVSKSTYZFY0wrOp9V+wp5CRlE=
X-Google-Smtp-Source: AKy350a0wrCpPqTwWS1Xn2kiu6qYe0sqO1p6QyH3x++TMuz9c5SSHM1Gmr3i6zo62IlTI0X2rBkqRg==
X-Received: by 2002:a17:902:868f:b0:19e:72c5:34df with SMTP id g15-20020a170902868f00b0019e72c534dfmr4954118plo.52.1682078762390;
        Fri, 21 Apr 2023 05:06:02 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id jg10-20020a17090326ca00b001a66e6bb66esm2670701plb.162.2023.04.21.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:06:01 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:35:47 +0530
Message-Id: <87edodigo4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCHv6 0/9] ext2: DIO to use iomap
In-Reply-To: <20230421112324.mxrrja2hynshu4b6@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Hello Ritesh,
>
> On Fri 21-04-23 15:16:10, Ritesh Harjani (IBM) wrote:
>> Hello All,
>>
>> Please find the series which rewrites ext2 direct-io path to use modern
>> iomap interface.
>
> The patches now all look good to me. I'd like to discuss a bit how to merge

Thanks Jan,


> them. The series has an ext4 cleanup (patch 3) and three iomap patches

Also Patch-3 is on top of ext4 journalled data patch series of yours,
otheriwse we might see a minor merge conflict.

https://lore.kernel.org/all/20230329154950.19720-6-jack@suse.cz/

> (patches 6, 8 and 9). Darrick, do you want to take the iomap patches through
> your tree?
>
> The only dependency is that patch 7 for ext2 is dependent on definitions
> from patch 6

That's right. Patch 6 defines TRACE_IOCB_STRINGS definition which both
ext2 and iomap tracepoints depend upon.

> so I'd have to pull your branch into my tree. Or I can take
> all the iomap patches through my tree but for that it would be nice to have
> Darrick's acks.
>
> I can take the ext4 patch through my tree unless Ted objects.

Sure, we might have to merge with Ted's ext4 tree as well to avoid the
merge conflict I mentioned above.

>
> I guess I won't rush this for the coming merge window (unless Linus decides
> to do rc8) but once we settle on the merge strategy I'll push out some

Ok.

> branch on which we can base further ext2 iomap conversion work.
>

Sure, will this branch also gets reflected in linux-next for wider testing?

-ritesh
