Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6857A55D481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiF0VLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 17:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiF0VLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:11:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD83DF05;
        Mon, 27 Jun 2022 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656364313; x=1687900313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UY4ciCF2PfXCTOF3LZITbZsRaQFQCfpZuDqHJ3No5q8=;
  b=LmGYzNT9jSBZJKcElBd9xKq7DE2/HBz+4u99kAqiqZ3pC3MbrNEI/MLe
   EJZB7yEHEu1KLDtNb6Y11Hfpapv7tCNDBox71jDpiPfEA6ADUd43ndJ8R
   qZmdTLkaxb7RzXXRXK5xaJqUX271CWiakBUIDgQ3ng0VnbicLmlEgxfFs
   J3Oe1fXYZJdMZU60nOIHTpyD0NUxUXgEJxo3HKTe2CNE+K/Qvv4jsFpkG
   33Artmu1JiPQtk8vuGmbPhhf83GMmV7MVWD8WT6l1nMFo2VPZuGVc7HMn
   LR5BC5tYrKDp/JpuHbsRUjs4vKYWYS06j5+Xfla1516BLR+kJTqDYC+/W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279108531"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279108531"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:11:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732480739"
Received: from jsagoe-mobl1.amr.corp.intel.com (HELO [10.209.12.66]) ([10.209.12.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:11:52 -0700
Message-ID: <7abba0a4-2480-18a1-4d9c-5973bb97b059@intel.com>
Date:   Mon, 27 Jun 2022 14:10:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 0/3] powerpc/pseries: add support for local secure
 storage called Platform KeyStore(PKS)
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220622215648.96723-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/22 14:56, Nayna Jain wrote:
> * Renamed PKS driver to PLPKS to avoid naming conflict as mentioned by
> Dave Hanson.

Thank you for doing this!  The new naming looks much less likely to
cause confusion.
