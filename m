Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC5593A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiHOTfA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbiHOTdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:33:45 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8168F61D94
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:45:13 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so5549703ilu.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc;
        bh=9oPYzoxTUmPE70g6i2LYiBhNZyppzQqx183QoEcMCCQ=;
        b=eLjst72CYktUpbOHHRyXPWmL0De64RbxRykFMxE1GIUmJiZJzRbV3Tnkmsw+3dK3DU
         AhJQCpDH39knn8wlJT/JlrFUAota5r+V04r+wbkgSCxz9murKEzOCZryswnd50dWqPtO
         DENx+Ifc4Kv387Gxk5vtUonQrZfs6v3MZhHbdhXNZyGZDQRZIrjAIIlYRNrGLl3oWiQU
         UPdUUfSMc09TEmTY4Q4aX0ui57UON8jIcPQVXmJ/SntbOtL0oyYo2yuNK5Asz3TAgptz
         XpxDax356D3xdFL1OdWojnGCcGwULYw54tPb5UJj5WRmS1CuGKppaxbUOU3TvTFk9fsz
         5jPA==
X-Gm-Message-State: ACgBeo1w1URvlLKVTIn7cgIbFl7wChwnosFeyh1aX1LJ11AKMxwphVXA
        kG2h16I3zJ2HhUYZKGemcuTZku3vyTkLGsJ0cgMaCcz/X8s9
X-Google-Smtp-Source: AA6agR5uwUM2YxE7qsFO9F/OS51SEy8+o9l2L7bCdL4FpylSAXW8bydIQo9YuxPxxdy1gsoTioStxxnoCsHry141DPvHOhuwHMbl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bce:b0:2e4:745b:d902 with SMTP id
 x14-20020a056e021bce00b002e4745bd902mr6367592ilv.265.1660589112295; Mon, 15
 Aug 2022 11:45:12 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:45:12 -0700
In-Reply-To: <20220815180715.GA3106610@roeck-us.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028084805e64c0839@google.com>
Subject: Re: [syzbot] upstream boot error: BUG: corrupted list in new_inode
From:   syzbot <syzbot+24df94a8d05d5a3e68f0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to create VM pool: failed to create GCE image: create image operation failed: &{Code:PERMISSIONS_ERROR Location: Message:Required 'read' permission for 'disks/ci-upstream-kasan-gce-root-test-job-test-job-image.tar.gz' ForceSendFields:[] NullFields:[]}.

syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2326737377=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 8dfcaa3d2
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=8dfcaa3d2828a113ae780da01f5f73ad64710e31 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220812-115356'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=8dfcaa3d2828a113ae780da01f5f73ad64710e31 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220812-115356'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=8dfcaa3d2828a113ae780da01f5f73ad64710e31 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220812-115356'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"8dfcaa3d2828a113ae780da01f5f73ad64710e31\"



Tested on:

commit:         fc4d146e virtio_net: Revert "virtio_net: set the defau..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=24df94a8d05d5a3e68f0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
