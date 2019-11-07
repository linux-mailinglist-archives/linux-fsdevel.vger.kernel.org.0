Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C1F30B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfKGN7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:59:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39216 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGN7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:59:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id 195so1674450lfj.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zUtIMonLuqK+iWfJbM+SRmDj7hvvfURy8hJeahep4/Y=;
        b=JXVM/MiDFcTdxX8cy44MVmFzKHZugo548aLLV3zop3h5hHOXAzYT6dhtTgattam5zn
         ZHy819NPhLltJnzWcFS5twZCvlR/8x3QLB6r3t4Po1F5oZONbOnSc5g9AgbLwvWauhAi
         yotfq3heZSqtcjbCavMNKNiRu404KbTrb8pgpcIdV9hTDi58CHPXULq304hVVwb2hBg0
         6LODreUSFrglTydMSlJB/vAnPGzhHTgpXFAVvGI4lUsl2yd05M9aWPgtQwLxEHa4m1b5
         FBx+2dk1QMCjwaR6V/2DuSKPMW6c83nrwZUb94/uuRwUAIdlFIbwl3gnqLM4MRRIp0Pm
         be8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zUtIMonLuqK+iWfJbM+SRmDj7hvvfURy8hJeahep4/Y=;
        b=SiMfoZNpm2LmezIoJ8+Uh7YjowykphHVFMUfloQpZjmOr+Orfkr7W3vZNgUaXyEdoI
         /mFI8mpZntxq/hCAkw3m6wBNE/WElFhBVrc3UTWjb8I/jjYfD6Es+s7R/KviedaTF8TR
         7CzngCUa2bKGLhcb3dLcIRjs0ifJljWO3l5TjWS3vznK3ajmOof9rWhOGO6VRxEiSHN/
         9/KRtk9KMSbHMNFqwEgSbUe5yhNQq4OoOVm0+Dtw7SPajD7Wlu/cCZnAtaC7VTiAhsLT
         gbVq01WdIjxb2EvtcvAwM1pmI5imPfHDkHMiWoJIffYJa6RRFXhEXJm5JE9srdfRGYay
         TOqw==
X-Gm-Message-State: APjAAAWP8IgQYTWNq6F2aURKbTOZQy0Ll6gbb0SqOmNhY61rB1mrmAU0
        wg2xrUbwDj0vFA14jhD3FZECcx5E9F1eYsiVwCgWEEYo09I=
X-Google-Smtp-Source: APXvYqxuBAK2h3pUAqLUZxbZFw8/Si0iNv8WQG1sEpgRk4H5vaETXamgdrUD+1wEZUttCeRSrNtVZwS+MutL6tIi1p8=
X-Received: by 2002:ac2:5930:: with SMTP id v16mr2612552lfi.67.1573135174476;
 Thu, 07 Nov 2019 05:59:34 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Nov 2019 19:29:23 +0530
Message-ID: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
Subject: LTP: diotest4.c:476: read to read-only space. returns 0: Success
To:     LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LTP test case dio04 test failed on 32bit kernel running linux next
20191107 kernel.
Linux version 5.4.0-rc6-next-20191107.

diotest4    1  TPASS  :  Negative Offset
diotest4    2  TPASS  :  removed
diotest4    3  TPASS  :  Odd count of read and write
diotest4    4  TPASS  :  Read beyond the file size
diotest4    5  TPASS  :  Invalid file descriptor
diotest4    6  TPASS  :  Out of range file descriptor
diotest4    7  TPASS  :  Closed file descriptor
diotest4    8  TPASS  :  removed
diotest4    9  TCONF  :  diotest4.c:345: Direct I/O on /dev/null is
not supported
diotest4   10  TPASS  :  read, write to a mmaped file
diotest4   11  TPASS  :  read, write to an unmapped file
diotest4   12  TPASS  :  read from file not open for reading
diotest4   13  TPASS  :  write to file not open for writing
diotest4   14  TPASS  :  read, write with non-aligned buffer
diotest4   15  TFAIL  :  diotest4.c:476: read to read-only space.
returns 0: Success
diotest4   16  TFAIL  :  diotest4.c:180: read, write buffer in read-only space
diotest4   17  TFAIL  :  diotest4.c:114: read allows  nonexistant
space. returns 0: Success
diotest4   18  TFAIL  :  diotest4.c:129: write allows  nonexistant
space.returns -1: Invalid argument
diotest4   19  TFAIL  :  diotest4.c:180: read, write in non-existant space
diotest4   20  TPASS  :  read, write for file with O_SYNC
diotest4    0  TINFO  :  2/15 test blocks failed

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-dio-tests/dio04

Test case source link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/io/direct_io/diotest4.c

Test case description:

* NAME
* diotest4.c
*
* DESCRIPTION
* The program generates error conditions and verifies the error
* code generated with the expected error value. The program also
* tests some of the boundary condtions. The size of test file created
* is filesize_in_blocks * 4k.
* Test blocks:
* [1] Negative Offset
* [2] Negative count - removed 08/01/2003 - robbiew
* [3] Odd count of read and write
* [4] Read beyond the file size
* [5] Invalid file descriptor
* [6] Out of range file descriptor
* [7] Closed file descriptor
* [8] Directory read, write - removed 10/7/2002 - plars
* [9] Character device (/dev/null) read, write
* [10] read, write to a mmaped file
* [11] read, write to an unmaped file with munmap
* [12] read from file not open for reading
* [13] write to file not open for writing
* [14] read, write with non-aligned buffer
* [15] read, write buffer in read-only space
* [16] read, write in non-existant space
* [17] read, write for file with O_SYNC

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: c68c5373c504078cc0e0edc7d5c88b47ca308144
  git describe: next-20191107
  make_kernelversion: 5.4.0-rc6
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/641/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/641

Best regards
Naresh Kamboju
