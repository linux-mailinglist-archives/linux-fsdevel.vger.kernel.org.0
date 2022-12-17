Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870FB64FB2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLQRON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 12:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLQROM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 12:14:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF09E0D1;
        Sat, 17 Dec 2022 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671297251; x=1702833251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T742U631P5R/7Sstc2JOA7hhkZJl2kAlvUpHW6NAwsM=;
  b=GeCfhQftAjOa0Xxn8dU6iWkzs0XfGKCLNslL5VTkqnSqAGKH8ESAEAW7
   FCDze/uYt5vNaR6oC0q7evjmjh1AnWYPEqJ380ccyU8FX4OLVQYdhLRiH
   t/2qr2LBgM4Ug1nH9Zy3ywz/M4tVqVIXxfmorKxBD1+HL/DeUaDGAe5Pk
   xz/M+JZAE1UMa5I4vNi8HY8nRuwn6ViNM8FXLmbUP2FxFhx5WkWruSbsG
   M9hVY0+z8xA87C1vX3ih3reIQbk5RNeZogeMDojpxTW5Uwpd01euMxPag
   p8+mi2H7ky/NGuGzHuBMT1CNf3uJndkNI12A7Dx96O2KH0HQDZgpolG9J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="317833231"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="317833231"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 09:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="718682316"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="718682316"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2022 09:14:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 09:14:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 09:14:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 09:14:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ+caazglJydb7rKiTL0OTkRAGHt6DHKG7y3/PeUl4WgH02I5cgPM67MmbsgL+811DjwdNxEjzBb/kfsRaX+JGFIrAdC01iQ1X/igNQ7DN4N8irq1xnHmnpeLg/s++BxeaOL8UwxCmC3WUx5sGSVd/jGh2hPfWfN+46Z6k6r01d5rquTY6YK8J4Wh2se6jLhzvivcn4EZ5IRuInBiSLcGb4EpaXcVdrp3wFWCEKbH41Q9xg9H6HV3f9+etqGTy2EqoB82BL+ErfIpilMHR2wdZUROjOZLi8rTEYF7upscfQfo1PlNibUS3QtptwRnKbyIjoA9JoUCOA0XIVNnNdh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z6VCEdK2uMNEJEtw4hT62row0BsdqCBRTcx8nYhgMU=;
 b=FhZxKrN6sLWc3TduBD8hnEs/M3TxEepdjO5kNAqLLWckaDXHhXad7mpG/yMN8L0eHqiKLVsRN79YVa1LMFm5PlTxov8Lk3kWPQH5UQJNqaoV50SDxLwgEr/f5pjRglG7Ga6kxuZcyWtpElHh5XmuAktvj4WMkOHdQxkGhmH4b6lwKKx4hP2B+0AF8NpcNyukozvoLtSQ/7G82QORUQW+XPtv/Grnll7UZ+czGsaqL+m0pVGePyKJYKHxsG7eVQvTDdDa0Dz/Wgq0b/nzYpkw7ePkZjckxt8rABskpFZWJ+YppEUL/2vc92wWsukAckuLgQm6T/wM2ieW8feNf3Vnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 17:14:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 17:14:09 +0000
Date:   Sat, 17 Dec 2022 09:14:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 2/8] reiserfs: use kmap_local_folio() in
 _get_block_create_0()
Message-ID: <Y5343RPkHRdIkR9a@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-3-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216205348.3781217-3-willy@infradead.org>
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0b51ce-3e32-4b9d-4765-08dae0521c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WT+Qi4G76W8F69ubfCofVAW+EqAXF3GI+bPt1kcS4BB4+6yyCe2oieDw1HHtOrWRdpozgOOvhZGupRJ4x0athhJ0Z/4Gf0j9poPxlqQiDJIlIXO47CkGuKHbxvZU1G4PIHymtSls6z3tfTkHnGlZSnymIpW2o61R1K0itIJTZEbakfsWSXworkZIu93ljG9c7x5v/8dWUtLNMDxesTsx4Vm+IU5uE0qYnSMalWLnjrsOhCYChZnGSbgHT2j/qSQdW8VuH37ybV209wMfhTFgIOt4DL7ggS+MYakeniz9ULOUJL7bMeMf3FDoxu5SB1GzT26xmbRt/nAck8+Y4OXvDonV5MLA9ZkvEklU2pLQyPCFvuh+aLdGAfmLQlx+bUOhOJAlatbahJI4SXTXQtSe7UHNmGWWTXR5odLMH+0zOdeJn95beFZqmJoVCjTDwVt2U1QzWrBug0aj4ul5MPg3ae9dJXyS1ZXu0Wr1z3WUmUkw6Q/e+xVnnQettdvpZPyJT+i4pwzUEUwzsJX/ULQB3VCsEstYwvpQRuWCwxoPKZCrFUiioJr4fbYzH4Mk2lp8WUqShJ5jqjpbvDZ41he4z3rKilIBLkf78GOvGX/4NSet0Apc4rRDdvn+0Ijy8cqZEiWE39/6alvmejHVPsumRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(82960400001)(86362001)(4326008)(2906002)(66556008)(66476007)(66946007)(8676002)(5660300002)(44832011)(38100700002)(83380400001)(478600001)(6916009)(54906003)(316002)(6486002)(41300700001)(8936002)(33716001)(6666004)(6506007)(9686003)(186003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q+CSUX/llidSFAqnU7PrRO7IV8DohNnRS/3//VVjZCCuxeJgvfDWPv2AWfNL?=
 =?us-ascii?Q?bCspREqFPpmi8zJDnZsWO+osxuD031reDpsvdTgLATGngajvrFjFAkpY6Jr6?=
 =?us-ascii?Q?Xxh2xh6/3HYVZlPftf/Xyk0ozJqP8asVgLB7cjmmWPGxbwUIxsjMSjn7M5Ma?=
 =?us-ascii?Q?8w4ABtaoPE4qFNFJJMNorrgT0u6adPP0pCuBzyu5VgtodpxqlEuMUluzcrvx?=
 =?us-ascii?Q?mPg4HtZCiI86EqV3wRAn8SwjNKW1v1HOrbwjZCKwJKGpftk76tF3PxF0Nz9S?=
 =?us-ascii?Q?ZMVTnZEfmQ8QywjwcRL9HARl5iYdynNpthwg55fdyMIQSP2VRE1/DzrdYs8l?=
 =?us-ascii?Q?90mfbnZFBFuq5i/X4a5iofbMVosUOGu6BZqa5t5WC67ioe5XlamADlCzM3Ej?=
 =?us-ascii?Q?Iv79PAyOQ3opyEICUkcSftG5d/G4zOxXpLXHgl7Nd94cS9GS5SON8Ssqhiqp?=
 =?us-ascii?Q?Qvc4Z7iRP/W69XJqicrR388A7megRokqogXYY3B79A4Bl2ORMjMtPivETqMp?=
 =?us-ascii?Q?+pxiieQEMpfX9+ZHY7u2rY1i9zmXHRHHnYQjcN/eD8q7BTRucexIN74RZGc0?=
 =?us-ascii?Q?xgA3wctKMcL3VN7bGDcUsikLj8Q7q8IB1IoHsZnctoBPn+68bYWJo35SkEgk?=
 =?us-ascii?Q?dz5nbuY6PWbUi5/xmmhYk9jlxl4+M/rI2Na10G5z8WQ2T/U8/j3faj6lM5Xa?=
 =?us-ascii?Q?679bMUacv+SyWZJtkyHG+0h+Kb/TV77sYbxCIglqH/beBWBiWdyaslYtllGr?=
 =?us-ascii?Q?ajBMZRwsIdjfJ1BG+Pu/LSAezpTeYk7KuVuL+eW61XGs5l4OpO4y8DtiJIsM?=
 =?us-ascii?Q?eCpo2Hd+nExNyxqQkQCtyqdP+h10n2m45PP3y+9Wg0iAeFq6y10Q3DwQV4zC?=
 =?us-ascii?Q?CSbdollDCFhF+sdGPjYQyg7z/KW7rAm47kbZHxTkcYqOcCpOUHypbBbx45NJ?=
 =?us-ascii?Q?HilX7PG6KJEjiexTCj6Z/L9WG7eoorp42mzOgSXoH36GGOkpmGQXX1USHqKb?=
 =?us-ascii?Q?F2MOjGH4P0YcTdEg81CFWtT6muzXYdSZe0QZWysP1oSHvfMZV+4EoTcjpdqt?=
 =?us-ascii?Q?zMw3j7GQXKSJOmN+/F9tRzr6CV9VoAMpQvT0t9A76FYp3hekuGTsEWwgNuIp?=
 =?us-ascii?Q?PxYv2IGTzFIdvhD/V6LxRvHqP12iiCO6WU7rDk4L39puTMIBFQSMf7PBccEP?=
 =?us-ascii?Q?LifWovMrWq0iobqdoOKScEMdw5QSI5Sa+VHYV7iJmcPfmRvcjRPE//ZrXPpV?=
 =?us-ascii?Q?OMcF3Ls4GnY1qZV4Sq8xdRUMiz8M2aGEv9FloT8nIpYOoS40y1pzzu2r+m4P?=
 =?us-ascii?Q?NhfdawLCelNz2BezlnWRfa+iMc1yC2s1g8esw/qltaNVurwCHxlxDQNweuP9?=
 =?us-ascii?Q?GCATN01uAsKse9qsnslUZBtDBmBFbB6OeI5mXUavlZNExYy6NVUBGH+9j1Vh?=
 =?us-ascii?Q?a7XLMCj97QSOzDk1ZbRvQ39ly6HzY7u2Sz061Hs8ltSonXuBdPwtn7gw62yI?=
 =?us-ascii?Q?hEZCYtZlyhq2V2JpJKwvTRI29SKykXnF+y64Cp0DaEs5z+tq8NEfq5czrvX7?=
 =?us-ascii?Q?pqZwYDlj4i26BsiG2CU5VxKM78UuAAB/j3yxU5Ue?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0b51ce-3e32-4b9d-4765-08dae0521c0c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 17:14:09.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTpVxBHnnmYU8/hEq0zVpRuHqMrE58rX9AUzQIO5InaqX2SGA9pKXYTnh+SnoTbP2QDP1s8arVhkrKS0Xodo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 08:53:41PM +0000, Matthew Wilcox (Oracle) wrote:
> Switch from the deprecated kmap() to kmap_local_folio().  For the
> kunmap_local(), I subtract off 'chars' to prevent the possibility that
> p has wrapped into the next page.

Thanks for tackling this one.  I think the conversion is mostly safe because I
don't see any reason the mapping is passed to another thread.

But comments like this make me leary:

         "But, this means the item might move if kmap schedules"

What does that mean?  That seems to imply there is something wrong with the
base code separate from the kmapping.

To the patch, I think subtracting chars might be an issue.  If chars > offset
and the loop takes the first 'if (done) break;' path then p will end up
pointing at the previous page wouldn't it?

Perhaps it is just safer to store the base pointer in this case?

Ira

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/reiserfs/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 41c0a785e9ab..0ca2d439510a 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -390,8 +390,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  	 * sure we need to.  But, this means the item might move if
>  	 * kmap schedules
>  	 */
> -	p = (char *)kmap(bh_result->b_page);
> -	p += offset;
> +	p = kmap_local_folio(bh_result->b_folio, offset);
>  	memset(p, 0, inode->i_sb->s_blocksize);
>  	do {
>  		if (!is_direct_le_ih(ih)) {
> @@ -439,8 +438,8 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  		ih = tp_item_head(&path);
>  	} while (1);
>  
> -	flush_dcache_page(bh_result->b_page);
> -	kunmap(bh_result->b_page);
> +	flush_dcache_folio(bh_result->b_folio);
> +	kunmap_local(p - chars);
>  
>  finished:
>  	pathrelse(&path);
> -- 
> 2.35.1
> 
