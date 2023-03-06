Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE96ACCE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCFSp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 13:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCFSp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:45:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055D2F797;
        Mon,  6 Mar 2023 10:45:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so6938464pln.12;
        Mon, 06 Mar 2023 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678128324;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YyDKvaa0tOYp/eEvFz9zK1xFXZMRKhjNF3Ei7f6Eyss=;
        b=ctmxpQbywNDOqcKMDlZAyQmR8eGfLU4qB230bBzKJToCZgrZx0RgzkkuDfWtVvHsM3
         hYtegy2QJ4t4Gl75QPJLG3e1w9NEEJwBBpyzZ2DckFCMFOJ/mJPNLonaQfGKKbpgSZT5
         +sjHVNDwbqSPkxjU0eif/dbCNcx69xLkbDBmZoiUJHu/wSOIsWeMykCtD3zbixLx8FJS
         FkrlrOVky6ZxbRrnDyIJlCcQgX19TplHqjCbK+ug43hlEqP11W4ooUdSlq/rijP/TPO6
         iR99NAORZxil7oErklDehjuLlqPL5EiDh/nW0VFLCBHf3QvtuO+zaNe3MlM+HWHsViq8
         5HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128324;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyDKvaa0tOYp/eEvFz9zK1xFXZMRKhjNF3Ei7f6Eyss=;
        b=IcMgbNUaqjgDoHFuOXTVi6qFz2Gr4Fo6Oa61N5+OjE1T0/6Oq4AZrX8iSS6fNIRK8N
         KYqBAmMTpvqAvtlYmCA0DbouoGDkKka/z7FrqP2chwQt5CP+qhjBzwwpawJqRPFhNTeI
         cRs/D2klZeHrYCbgboF25ymUsvrroMmhKoDlNihMf1xw7n/YlHo4nUOFI09K9HKfwgmg
         zjdvNOiLHqrRcojQoCvY1oKAMGGrjKWXciSrqC0J8AqoM1yQqFScDJ2VvO3gVxDiO47Z
         s2ySbxW4jzzJrJyaEQRy4ID9pooJq/uDublehEqL4xFa9ZyRRK1U4EFttZpOSuVY6p9F
         /Dxg==
X-Gm-Message-State: AO0yUKWcfCRqIXwvtczfb+EcN3e358xTpNrJwVg5JUED59+KM/N1vevC
        cdoFSV8s4iCRwwdedDHLBx98oQNgHRXGcg==
X-Google-Smtp-Source: AK7set+Na9mJ5C+nzJKLRaVrRfp4syWfb7sw8KnVkIqBwTsJDjFORZ98wovRLXtCpxUjwqPqW3UsSw==
X-Received: by 2002:a05:6a20:a11a:b0:cd:52a:faf2 with SMTP id q26-20020a056a20a11a00b000cd052afaf2mr13914257pzk.53.1678128323884;
        Mon, 06 Mar 2023 10:45:23 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00586fbbdf6e4sm6632990pfu.34.2023.03.06.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:45:23 -0800 (PST)
Date:   Tue, 07 Mar 2023 00:15:13 +0530
Message-Id: <87y1o9vhvq.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/31] ext4: Convert ext4_writepage() to use a folio
In-Reply-To: <20230126202415.1682629-6-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> Prepare for multi-page folios and save some instructions by converting
> to the folio API.

Mostly a straight forward change. The changes looks good to me.
Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

In later few patches I see ext4_readpage converted to ext4_read_folio().
I think the reason why we have not changed ext4_writepage() to
ext4_write_folio() is because we anyway would like to get rid of
->writepage ops eventually in future, so no point.
I think there is even patch series from Jan which tries to kill
ext4_writepage() completely.

-ritesh
